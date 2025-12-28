Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example assumes you have a simple Solidity contract (e.g., a basic staking contract) and want to deploy it to a local Hardhat network or testnet.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
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

### Deployment Script: `deploy.js`

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const balance = await deployer.getBalance();
  console.log("Account balance:", balance.toString());

  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
  const simpleStaking = await SimpleStaking.deploy();

  await simpleSt