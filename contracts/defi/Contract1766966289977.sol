```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract SimpleLender {
    IERC20 public immutable token;
    mapping(address => uint256) public loans;

    constructor(address _token) {
        token = IERC20(_token);
    }

    // Borrow tokens by transferring from lender to borrower
    function borrow(uint256 amount) external {
        require(amount > 0, "Amount > 0");
        loans[msg.sender] += amount;
        require(token.transferFrom(address(this), msg.sender, amount), "Transfer failed");
    }

    // Repay borrowed tokens
    function repay(uint256 amount) external {
        require(amount > 0 && amount <= loans[msg.sender], "Invalid amount");
        loans[msg.sender] -= amount;
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }
}
```