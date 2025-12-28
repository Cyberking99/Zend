Certainly! Below is a simple example of a deployment and simulation script for a basic DeFi Solidity contract using Hardhat and ethers.js. The example includes:

- A simple Solidity contract (`SimpleBank`) that allows deposits and withdrawals.
- A deployment script to deploy the contract.
- A simulation script to interact with the contract after deployment.

---

### 1. Solidity Contract: SimpleBank.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
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

### 2. Deployment Script: `scripts/deploy.js`

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:",