Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat, a popular Ethereum development environment.

### Example Solidity Contract (Simple DeFi Staking)

```solidity
// contracts/SimpleStaking.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // reward tokens per block per staked token

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        updateReward(msg.sender);
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        updateReward(msg.sender);
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function claimReward() external {
        updateReward(msg.sender);
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    mapping(address => uint256) lastUpdateBlock;

    function updateReward(address user) internal {
        uint256 blocksPassed = block.number - lastUpdateBlock[user];
        if (blocksPassed > 0) {
            rewards[user