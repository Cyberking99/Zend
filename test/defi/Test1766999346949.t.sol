Sure! Below is a small example of a test for a simple DeFi Solidity contract using **Foundry's forge-std** testing framework.

---

### Example Solidity Contract: SimpleBank.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
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

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### Test using forge-std (Foundry)

Create a test file `SimpleBank.t.sol` in your `test` folder:

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
    }

    function testDeposit() public {
        // Start acting as user
        vm.prank(user);

        // Deposit