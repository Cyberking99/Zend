Sure! Below is a simple example of a Solidity test using **forge-std** (Foundry's standard library) for a basic DeFi contract. I'll create a minimal DeFi contract (a simple vault that accepts deposits and allows withdrawals), then write a Forge test for it.

---

### Step 1: Simple DeFi Contract (Vault.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Vault {
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Helper function to check contract balance
    function totalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### Step 2: Forge Test (Vault.t.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../