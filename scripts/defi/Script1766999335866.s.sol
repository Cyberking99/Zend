Certainly! Below is a simple example of a deployment and simulation script for a basic DeFi Solidity contract using Hardhat and ethers.js. The example contract is a minimal "SimpleBank" that allows deposits and withdrawals.

---

### 1. Solidity Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit positive amount");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### 2. Deployment & Simulation Script: `scripts/deploy-and-simulate.js`

```javascript
const { ethers } = require("hardhat");

async function main() {
  // Deploy the contract
  const SimpleBank = await ethers.getContractFactory("SimpleBank");
  const bank = await SimpleBank.deploy();
  await bank.deployed();