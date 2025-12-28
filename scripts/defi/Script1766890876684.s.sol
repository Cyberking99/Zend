Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This example assumes you have a Solidity contract named `SimpleDeFi.sol` that you want to deploy to a local or test network.

---

### 1. Example Solidity Contract (`SimpleDeFi.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### 2. Deployment Script (`scripts/deploy.js`)

```javascript
const hre = require("hardhat");

async function main() {
  // Compile contracts if needed
  await hre.run('compile');

  // Get contract factory
  const SimpleDeFi = await hre.ethers.getContractFactory("SimpleDeFi");

  // Deploy contract
  const simpleDeFi = await SimpleDeFi.deploy();

  // Wait for deployment to finish
  await simpleDeFi.deployed();

  console.log("SimpleDeFi deployed to:", simple