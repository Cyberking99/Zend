Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example includes:

1. A simple Solidity contract that represents a basic DeFi vault where users can deposit and withdraw Ether.
2. A deployment script in JavaScript to deploy the contract to a local Hardhat network.

---

### 1. Solidity Contract: `SimpleDeFiVault.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFiVault {
    mapping(address => uint256) public balances;

    // Deposit Ether into the vault
    function deposit() external payable {
        require(msg.value > 0, "Must deposit some ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the vault
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Check balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### 2. Deployment Script: `deploy.js`

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleDeFiVault = await ethers.getContractFactory