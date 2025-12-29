Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script deploys a simple staking contract where users can stake ETH and earn rewards.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // reward per block per ETH staked

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Simplified reward calculation for demonstration
    function calculateReward(address staker) public view returns (uint256) {
        // In real contracts, you'd track block numbers and time
        return stakes[staker] * rewardRate / 1e18;
    }

    function claimReward() external {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward available");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    // Allow contract to