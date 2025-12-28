Certainly! Below is a simple example of a Forge test for a basic DeFi Solidity contract. We'll create a minimal DeFi contract that allows users to deposit and withdraw ETH, and then write a Forge test using `forge-std`.

---

### Solidity Contract: `SimpleDeFi.sol`

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

### Forge Test: `SimpleDeFi.t.sol`

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
        // Label the user address for easier debugging
        vm.label(user, "User");
    }

    function test