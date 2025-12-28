Certainly! Below is a simple deployment script using Hardhat (a popular Ethereum development environment) to deploy a basic DeFi Solidity contract. For the sake of this example, let's assume you have a simple DeFi contract called `SimpleDeFi.sol` that allows users to deposit and withdraw Ether.

---

### 1. Example Solidity Contract (`SimpleDeFi.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must deposit more than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the contract
    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Get contract balance (for testing)
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### 2. Hardhat Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  // Get