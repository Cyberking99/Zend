Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example assumes you have a simple Solidity contract like a basic staking contract, and the script will deploy it to a local Hardhat network.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
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

### Deployment Script: `scripts/deploy.js`

```js
async function main() {
  // Get the contract factory
  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");

  // Deploy the contract
  const staking = await SimpleStaking.deploy();

  // Wait for deployment to finish
  await staking.deployed();

  console.log("SimpleStaking deployed to:", staking.address);
}

main()
  .then(() => process.exit(0))
  .catch((error)