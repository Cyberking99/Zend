```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract SimpleLender {
    IERC20 public immutable token;
    mapping(address => uint256) public deposits;

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
    }

    // Deposit tokens into the contract
    function deposit(uint256 amount) external {
        require(amount > 0, "Amount must be > 0");
        deposits[msg.sender] += amount;
        require(token.transfer(address(this), amount), "Transfer failed");
    }

    // Withdraw deposited tokens
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }
}
```