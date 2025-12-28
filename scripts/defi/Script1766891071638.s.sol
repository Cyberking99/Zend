Certainly! Below is a simple example of a deployment script using Hardhat for a basic DeFi Solidity contract. The example contract is a simple staking contract where users can stake ETH and withdraw it later.

---

### Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Stake ETH by sending value to this function
    function stake() external payable {
        require(msg.value > 0, "Must stake more than 0");
        stakes[msg.sender] += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    // Withdraw staked ETH
    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // View stake of a user
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

  console.log("Deploying contracts with the account:", deployer.address