Certainly! Below is a small example of a test for a simple DeFi Solidity contract using **Foundry's forge-std** testing framework.

---

### Example: Simple DeFi contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test using forge-std

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleDeFi.sol";

contract SimpleDeFiTest is Test {
    SimpleDeFi defi;

    function setUp() public {
        defi = new SimpleDeFi();
    }

    function testDeposit() public {
        // Deposit 1 ether
        defi.deposit{value: 1 ether}();
        assertEq(defi.balances(address(this)), 1 ether);
    }

    function testWithdraw() public {
        // Deposit 2 ether first
        defi.deposit{value: 2 ether}();
        assertEq(defi.bal