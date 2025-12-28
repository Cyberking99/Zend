Sure! Below is a simple example of a Solidity test using **forge-std** for a basic DeFi contract. The example assumes you have a simple DeFi contract that allows depositing and withdrawing Ether.

---

### Simple DeFi Contract (Solidity)

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
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test using forge-std (Foundry)

Create a test file like `SimpleDeFi.t.sol`:

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
        // Deposit 1 ether from address(this)
        defi.deposit{value: 1 ether}();

        // Check balance updated
        uint256 bal = defi.balances