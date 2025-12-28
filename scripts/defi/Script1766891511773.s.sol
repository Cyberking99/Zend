Certainly! Below is a simple example of a deployment script using Hardhat for a basic DeFi Solidity contract. This example assumes you have a simple DeFi contract like a basic staking contract.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 100; // Example fixed reward rate

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
        stakes[msg.sender] += msg.value;
    }

    function calculateReward(address user) public view returns (uint256) {
        return stakes[user] * rewardRate / 1000;
    }

    function claimReward() external {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward available");
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);
    }

    // Allow contract to receive ETH rewards
    receive() external payable {}
}
```

---

### Deployment Script: `scripts/deploy.js`

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleStaking = await ethers.getContractFactory("