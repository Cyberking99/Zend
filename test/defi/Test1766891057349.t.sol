Certainly! Below is a minimal example of a Solidity DeFi contract and a corresponding test using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract: SimpleVault.sol

A simple vault contract where users can deposit and withdraw ETH.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVault {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit ETH into the vault
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH from the vault
    function withdraw(uint256 amount) external {
        require(amount > 0, "Must withdraw > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Helper to get contract balance
    function totalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### Forge Test: SimpleVault.t.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test