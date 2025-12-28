Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script compiles the contract and deploys it to a local Hardhat network or any configured network.

### Example Solidity Contract (SimpleDeFi.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
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

### Deployment Script (deploy.js)

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleDeFi = await ethers.getContractFactory("SimpleDeFi");
  const simpleDeFi = await SimpleDeFi.deploy();

  await simpleDeFi.deployed();

  console.log("SimpleDeFi deployed to:", simpleDeFi.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1