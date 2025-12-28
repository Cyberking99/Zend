Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat, a popular Ethereum development environment. The script deploys a simple staking contract where users can stake ETH and earn rewards.

---

### 1. Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // reward per block per staked ETH (simplified)

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Simplified reward calculation
    function claimReward() external {
        uint256 reward = stakes[msg.sender] * rewardRate / 1e18;
        rewards[msg.sender] += reward;
    }

    // Withdraw rewards
    function withdrawReward() external {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    // Allow