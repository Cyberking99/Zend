Certainly! Below is a simple example of a deployment and interaction script using Hardhat for a basic DeFi-style Solidity contract. The contract is a minimalistic staking contract where users can stake ETH and withdraw it later.

---

### Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Stake ETH by sending it to this function
    function stake() external payable {
        require(msg.value > 0, "Must stake positive amount");
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

    // Get stake of a user
    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Deployment & Simulation Script (JavaScript with Hardhat)

Save this as `scripts/deploy_and_simulate.js` in your Hardhat project.

```js
async function main() {
  const [de