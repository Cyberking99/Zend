Sure! Below is a simple example of a Solidity test using **Foundry's `forge-std`** library to test a basic DeFi contract. I'll create a minimal DeFi contract that allows users to deposit and withdraw ETH, and then write a test for it.

---

### Example DeFi Contract: `SimpleDeFi.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
}
```

---

### Test Using Forge (`forge-std`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleDeFi.sol";

contract SimpleDeFiTest is Test {
    SimpleDeFi defi;

    address user