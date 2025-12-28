Certainly! Below is a simple example of a Solidity DeFi contract along with a small test written using **Foundry's forge-std** framework. The example contract is a minimalistic **SimpleBank** that allows users to deposit and withdraw Ether.

---

### Solidity Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Deposit Ether into the bank
    function deposit() external payable {
        require(msg.value > 0, "Must send Ether");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the bank
    function withdraw(uint256 amount) external {
        require(amount > 0, "Must withdraw positive amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit Withdraw(msg.sender, amount);
    }

    // Check the balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### Forge Test: `SimpleBank.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;