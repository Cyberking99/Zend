```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract SimpleLending {
    IERC20 public immutable token;
    mapping(address => uint256) public debts;

    constructor(address _token) {
        token = IERC20(_token);
    }

    // Borrow tokens by depositing collateral (simplified)
    function borrow(uint256 amount) external {
        // For simplicity, no collateral checks here
        debts[msg.sender] += amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }

    // Repay borrowed tokens
    function repay(uint256 amount) external {
        require(debts[msg.sender] >= amount, "Repay exceeds debt");
        debts[msg.sender] -= amount;
        require(token.transferFrom(msg.sender, address(this), amount), "TransferFrom failed");
    }
}
```