Certainly! Below is a simple example of a Solidity test using **Foundry's forge-std** library. This test covers a minimal DeFi contract that allows users to deposit and withdraw Ether.

---

### Solidity Contract: `SimpleDeFi.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    // Deposit Ether into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Forge Test: `SimpleDefi.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleDeFi.sol";

contract SimpleDeFiTest is Test {
    SimpleDeFi defi;
    address user = address(0x1234);

    function setUp() public {
        defi = new SimpleDeFi();
        // Fund the user with some ETH for testing
        vm.deal(user, 10 ether);
    }

    function testDeposit() public {
        vm.pr