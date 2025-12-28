Certainly! Below is a simple example of a deployment script using Hardhat for a basic DeFi Solidity contract. The contract is a minimalistic staking contract where users can stake ETH and withdraw it later.

---

### 1. Solidity Contract (`contracts/SimpleStaking.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public balances;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Stake ETH into the contract
    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
        balances[msg.sender] += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    // Withdraw staked ETH
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // View staked balance
    function stakedBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### 2. Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts