Certainly! Below is a simple example of a deployment and simulation script using Hardhat for a basic DeFi Solidity contract. This script deploys a simple staking contract, then simulates a user staking some tokens and checking their balance.

---

### Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
        stakes[msg.sender] += msg.value;
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Deployment & Simulation Script: `scripts/deploy-and-simulate.js`

```javascript
const { ethers } = require("hardhat");

async function main() {
  // Deploy the contract
  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
  const staking = await SimpleStaking.deploy();
  await staking.deployed();
  console.log("SimpleStaking deployed to:", staking.address);

  // Get signer accounts
  const [deployer, user] = await ethers.getSigners();

  // Simulate user staking 1 ETH
  const stakeAmount = ethers.utils.parseEther("1.0");
  const tx = await staking.connect(user).stake({ value: stakeAmount });
  await tx