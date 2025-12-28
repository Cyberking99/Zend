Certainly! Below is a small example of how you can write a test for a simple DeFi Solidity contract using **forge-std** (Foundry's standard library). The example contract will be a basic lending contract where users can deposit ETH and withdraw it.

---

### Solidity Contract (Lending.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lending {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Forge Test (Lending.t.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Lending.sol";

contract LendingTest is Test {
    Lending lending;

    function setUp() public {
        lending = new Lending();
    }

    function testDeposit() public {
        // Deposit 1 ether
        lending.deposit{value: 1 ether}();

        // Check balance updated
        assertEq(lending.balances(address(this)), 1 ether);
    }

    function testWithdraw() public {
        //