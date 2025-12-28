Certainly! Below is a simple example of a deployment script for a DeFi Solidity contract using Hardhat and ethers.js. This script assumes you have a basic DeFi contract (e.g., a simple staking contract) compiled and ready to be deployed.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
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

### Deployment Script: `scripts/deploy.js`

```javascript
async function main() {
  // Get the contract factory
  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
  
  // Deploy the contract
  const simpleStaking = await SimpleStaking.deploy();

  // Wait for deployment to finish
  await simpleStaking.deployed();

  console.log("SimpleStaking deployed to:", simpleStaking.address);
}

main()
  .then(() => process