Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example assumes you have a simple DeFi contract like a basic staking contract.

---

### 1. Example Solidity Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;
    uint256 public totalStaked;

    function stake() external payable {
        require(msg.value > 0, "Must stake more than 0");
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### 2. Deployment Script (deploy.js)

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Staking = await ethers.getContractFactory("Staking");
  const staking = await Staking.deploy();

  await staking.deployed();

  console.log("Staking contract deployed to:", staking.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error