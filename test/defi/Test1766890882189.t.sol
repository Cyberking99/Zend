Certainly! Below is a small example of a test for a simple DeFi Solidity contract using **Foundry** (forge-std). I'll create a minimal DeFi contract (e.g., a simple staking contract) and then write a test for it.

---

### Solidity Contract: SimpleStaking.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public balances;

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        balances[msg.sender] += msg.value;
        emit Staked(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Must withdraw > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
}
```

---

### Forge Test: SimpleStaking.t.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleStaking.sol";

contract SimpleStakingTest is Test {
    SimpleStaking staking;

    address user = address(