Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. It includes:

- A simple Solidity contract (`SimpleDeFi.sol`) that allows users to deposit and withdraw Ether.
- A Hardhat deployment script (`deploy.js`) to deploy the contract to a local or test network.
- A basic test script to simulate deposits and withdrawals.

---

### 1. Solidity Contract: `SimpleDeFi.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    // Deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Get contract balance
    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### 2. Hardhat Deployment Script: `scripts/deploy.js`

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address