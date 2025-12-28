Certainly! Below is a small example of a Solidity test using **Foundry's forge-std** library for a simple DeFi contract. The example covers a basic scenario: a simple lending contract where users can deposit and withdraw ETH.

---

### Example Solidity Contract: `SimpleLending.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLending {
    mapping(address => uint256) public balances;

    // Deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Forge Test: `SimpleLending.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleLending.sol";

contract SimpleLendingTest is Test {
    SimpleLending lending;

    address user = address(0x1234);

    function setUp() public {
        lending = new SimpleLending();
        // Label the user address for easier debugging
        vm.label(user, "User");
    }

    function testDeposit