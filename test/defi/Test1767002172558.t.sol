Sure! Below is a simple example of a Solidity contract and a corresponding test using **Foundry's forge-std** testing framework.

---

### Example Solidity Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Forge Test: `SimpleBank.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleBank.sol";

contract SimpleBankTest is Test {
    SimpleBank bank;
    address user = address(0x1234);

    function setUp() public {
        bank = new SimpleBank();
        // Label the user address for better trace readability
        vm.label(user, "User");
    }

    function testDeposit() public {
        // Simulate calls from user
        vm.prank(user);