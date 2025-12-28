Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This script deploys a simple staking contract where users can stake ETH and earn rewards.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // Reward per block per staked ETH (for simplicity)

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function claimRewards() external {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards to claim");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    // Simulate reward accumulation (for demo purposes)
    function distributeRewards() external {
        // In a real contract, you'd have more complex logic and security
        for (uint i = 0; i < 10; i++) { // Simulate 10