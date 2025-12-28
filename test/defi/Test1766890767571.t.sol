Sure! Below is a small example of a Solidity test using **forge-std** (Foundry's standard library) to test a simple DeFi contract. The example contract is a minimalistic staking contract where users can deposit ETH and then withdraw it.

---

### 1. Simple DeFi Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public balances;

    // Deposit ETH to stake
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw staked ETH
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
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
    Staking staking;

    function setUp() public {
        staking = new Staking();
    }

    function testDeposit() public {
        // Deposit 1 ether
        staking.deposit{value: 1 ether}();

        // Check balance updated
        assertEq