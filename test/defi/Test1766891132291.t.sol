Sure! Below is a simple example of a Solidity test using **foundry's forge-std** for a basic DeFi contract. I'll create a minimal DeFi contract (a simple staking contract) and then write a test for it using Forge.

---

### 1. Minimal DeFi Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        stakes[msg.sender] += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### 2. Forge Test (Staking.t.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Staking.sol";

contract StakingTest is Test {
    Staking staking