Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example contract is a simple staking contract where users can stake ETH and withdraw it later.

---

### 1. Solidity Contract (`Staking.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public balances;

    // Stake ETH by sending it to the contract
    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
        balances[msg.sender] += msg.value;
    }

    // Withdraw staked ETH
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance to withdraw");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Get balance of staker
    function getBalance(address staker) external view returns (uint256) {
        return balances[staker];
    }
}
```

---

### 2. Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Staking = await ethers.getContractFactory("Staking");