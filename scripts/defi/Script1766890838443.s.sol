Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This example assumes you have a simple DeFi contract, e.g., a basic staking contract, and you want to deploy it on a local Hardhat network or testnet.

---

### Example Solidity Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Deployment Script (deploy.js)

```javascript
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