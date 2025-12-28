Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This example assumes you have a Solidity contract called `SimpleDeFi.sol` that you want to deploy to a local or test network.

---

### Example Solidity Contract (`SimpleDeFi.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    // Deposit ETH into the contract
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the contract
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

### Deployment Script (`scripts/deploy.js`)

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleDeFi = await ethers.getContractFactory("SimpleDeFi");
  const simpleDeFi = await SimpleDeFi.deploy();

  await simpleDeFi.deployed();

  console.log("SimpleDeFi deployed to:", simpleDe