Certainly! Below is a simple example of a deployment script using Hardhat for a basic DeFi Solidity contract. This example assumes you have a Solidity contract named `SimpleDeFi.sol` (for example, a basic staking contract) and you want to deploy it to a local Hardhat network or testnet.

---

### 1. Example Solidity Contract (`SimpleDeFi.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
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

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const SimpleDeFi = await ethers.getContractFactory("SimpleDeFi");
  const simpleDeFi =