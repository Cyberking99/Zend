Certainly! Below is a simple example of a deployment and interaction script for a basic DeFi Solidity contract using Hardhat and ethers.js. The example contract is a minimal "SimpleBank" where users can deposit and withdraw Ether.

---

### Step 1: Solidity Contract (SimpleBank.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit Ether into the bank
    function deposit() external payable {
        require(msg.value > 0, "Must deposit some Ether");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the bank
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Check balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### Step 2: Deployment & Simulation Script (deploy.js)

```js
const { ethers } = require("hardhat");

async function main() {
  // Get the contract factory
  const SimpleBank = await ethers