Certainly! Below is a simple deployment script using Hardhat for a basic DeFi Solidity contract. This example assumes you have a simple staking contract that allows users to stake ETH and earn rewards.

---

### 1. Example Solidity Contract (`Staking.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;

    uint256 public rewardRate = 100; // reward per block

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getReward() external {
        uint256 reward = calculateReward(msg.sender);
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    function calculateReward(address staker) public view returns (uint256) {
        // Dummy reward calculation, in real contract this would be more complex
        return stakes[staker] / 1000 * rewardRate;
    }

    // Allow contract to receive ETH
    receive() external payable {}
}
```

---

### 2. Deployment Script (`scripts/deploy.js`