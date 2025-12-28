Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This script assumes you have a Solidity contract named `MyDeFiContract.sol` in your `contracts` directory.

---

### Sample Solidity Contract (`MyDeFiContract.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyDeFiContract {
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

### Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  // Get the contract factory
  const MyDeFiContract = await ethers.getContractFactory("MyDeFiContract");

  // Deploy the contract
  const myDeFiContract = await MyDeFiContract.deploy();

  // Wait for deployment to finish
  await myDeFiContract.deployed();

  console.log("MyDeFiContract deployed to:", myDeFiContract.address);

  // Simple simulation: deposit 1 ETH from the deployer
  const [deployer