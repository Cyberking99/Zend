```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleLending {
    IERC20 public immutable token;
    mapping(address => uint256) public deposits;

    constructor(address _token) {
        token = IERC20(_token);
    }

    // Deposit tokens into the contract
    function deposit(uint256 amount) external {
        require(amount > 0, "Zero deposit");
        deposits[msg.sender] += amount;
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    // Withdraw deposited tokens
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        require(token.transfer(msg.sender, amount), "Transfer failed");
    }
}
```