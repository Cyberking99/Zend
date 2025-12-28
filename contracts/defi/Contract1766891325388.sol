```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract SimpleLending {
    IERC20 public immutable token;
    mapping(address => uint256) public deposits;

    constructor(address _token) {
        token = IERC20(_token);
    }

    // Deposit tokens into the contract
    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        deposits[msg.sender] += amount;
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    // Withdraw deposited tokens
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        require(token.transferFrom(address(this), msg.sender, amount) == false, "Use transfer instead");
        // Note: transferFrom from contract to user will fail, use token.transfer below
        // Corrected:
        // token.transfer(msg.sender, amount);
    }
}
```

---

**Note:** The `withdraw` function currently uses `transferFrom` incorrectly; it should use `token.transfer`. Here's the corrected withdraw function:

```solidity
function withdraw(uint256 amount) external {
    require(deposits[msg.sender] >= amount, "Insufficient balance");
    deposits[msg