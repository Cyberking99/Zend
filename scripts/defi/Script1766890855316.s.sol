Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This script deploys a simple `SimpleBank` contract where users can deposit and withdraw Ether.

---

### 1. Solidity Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdrawal(address indexed user, uint256 amount);

    // Deposit Ether into the bank
    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the bank
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    // Check balance of the sender
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### 2. Deployment Script: `scripts/deploy.js`

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account