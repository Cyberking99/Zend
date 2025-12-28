Certainly! Below is a simple example of a deployment and simulation script for a basic DeFi Solidity contract using Hardhat and ethers.js. The example contract is a simple staking contract where users can stake ETH and earn rewards.

---

### Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 10; // 10% reward for simplicity

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
        // Calculate reward immediately for simplicity
        rewards[msg.sender] += (msg.value * rewardRate) / 100;
    }

    function withdraw() external {
        uint256 staked = stakes[msg.sender];
        uint256 reward = rewards[msg.sender];
        require(staked > 0, "No stake to withdraw");

        stakes[msg.sender] = 0;
        rewards[msg.sender] = 0;

        payable(msg.sender).transfer(staked + reward);
    }

    // Fallback to accept ETH
    receive() external payable {}
}
```

---

### Deployment & Simulation Script (`scripts/deploy-and-simulate.js`)

```javascript
const { ethers } = require("hardhat");

async function main() {
  // Deploy