Certainly! Here's a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat and ethers.js. This script deploys a simple staking contract where users can stake tokens.

---

### Example Solidity Contract (`Staking.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract Staking {
    IERC20 public stakingToken;
    mapping(address => uint256) public balances;

    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake zero");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        stakingToken.transfer(msg.sender, amount);
    }
}
```

---

### Deployment Script (`scripts/deploy.js`)

```js
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // Deploy a mock ERC20 token for staking (for simulation