Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This example assumes you have a simple Solidity contract like a basic staking contract.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must stake some ether");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getStake(address staker) external view returns (uint256) {
        return stakes[staker];
    }
}
```

---

### Deployment Script: `scripts/deploy.js`

```javascript
async function main() {
  // Get the contract factory
  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");

  // Deploy contract
  const simpleStaking = await SimpleStaking.deploy();
  await simpleStaking.deployed();

  console.log("SimpleStaking deployed to:", simpleStaking.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit