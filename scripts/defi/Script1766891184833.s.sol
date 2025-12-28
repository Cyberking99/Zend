Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script assumes you have a simple Solidity contract like a basic staking contract.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // reward per stake unit

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function claimReward() external {
        uint256 reward = stakes[msg.sender] * rewardRate / 1e18;
        require(reward > 0, "No rewards");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    // Function to fund contract with rewards
    receive() external payable {}
}
```

---

### Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with