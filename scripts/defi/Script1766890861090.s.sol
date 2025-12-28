Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script assumes you have a Solidity contract named `SimpleDeFi.sol` in your `contracts` folder.

---

### Example Solidity Contract: SimpleDeFi.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    // Deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Check balance
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Deployment Script (JavaScript) using Hardhat

Create a file `scripts/deploy.js`:

```js
async function main() {
  // Get the contract to deploy
  const SimpleDeFi = await ethers.getContractFactory("SimpleDeFi");
  const simpleDeFi = await SimpleDeFi.deploy();

  await simpleDeFi.deployed();

  console.log("SimpleDeFi deployed to:", simpleDeFi.address);