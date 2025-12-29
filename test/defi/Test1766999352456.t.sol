Sure! Below is a simple example of a Solidity test using **forge-std** (the Forge testing framework from Foundry) for a basic DeFi contract. I'll create a minimal DeFi contract that allows users to deposit and withdraw ETH, and then write a test to verify the deposit and withdrawal functionality.

---

### Example Solidity DeFi Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) public balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit ETH into the bank
    function deposit() external payable {
        require(msg.value > 0, "Must deposit some ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw ETH from the bank
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // Get balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### Forge Test: `SimpleBank.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.