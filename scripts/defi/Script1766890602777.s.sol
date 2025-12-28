Certainly! Below is a simple example of a deployment and interaction script for a basic DeFi-like Solidity contract using Hardhat and ethers.js. This script deploys a simple staking contract, simulates a user staking some tokens, and then checks the staked balance.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    event Staked(address indexed user, uint256 amount);

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        stakes[msg.sender] += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Deployment & Simulation Script: `scripts/deploy_and_stake.js`

```javascript
const hre = require("hardhat");

async function main() {
  // Deploy the contract
  const SimpleStaking = await hre.ethers.getContractFactory("SimpleStaking");
  const staking = await SimpleStaking.deploy();
  await staking.deployed();

  console.log("SimpleStaking deployed to:", staking.address);

  // Get signers
  const [owner, user] = await hre.ethers.getSigners();

  // User stakes 1 ETH
  const stakeAmount =