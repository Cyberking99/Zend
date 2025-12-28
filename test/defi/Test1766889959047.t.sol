Sure! Below is a simple example of a Solidity test for a basic DeFi contract using **Foundry's forge-std** testing framework.

Let's say you have a simple DeFi contract that allows users to deposit and withdraw ETH.

---

### Example Solidity Contract: `SimpleDeFi.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    // Deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
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

### Test Using Foundry (forge-std)

Create a test file `SimpleDeFi.t.sol`:

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
        defi.deposit{value: