Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat, a popular Ethereum development environment. The example assumes you have a simple Solidity contract like a basic staking contract.

---

### Example Solidity Contract (`contracts/SimpleStaking.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // reward per block for simplicity

    function stake() external payable {
        require(msg.value > 0, "Must stake some ether");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Simplified reward calculation
    function getReward() external {
        uint256 reward = stakes[msg.sender] / 1e16 * rewardRate; // dummy calculation
        rewards[msg.sender] += reward;
    }
}
```

---

### Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleStaking = await ethers.getContract