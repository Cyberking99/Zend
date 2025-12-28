Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script assumes you have a simple Solidity contract like a basic staking contract.

---

### Example Solidity Contract (`Staking.sol`)

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
}
```

---

### Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  // Get the ContractFactory and Signers here.
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const Staking = await ethers.getContractFactory("Staking");
  const staking = await Staking.deploy();

  await staking.deployed();

  console.log("Staking contract deployed to:", staking.address);

  // Example simulation: Stake 1 ETH from deployer
  const stakeTx = await staking.stake({ value: ethers.utils.parseEther("1") });
  await stakeTx.wait();
  console