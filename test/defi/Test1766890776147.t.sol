Certainly! Below is a simple example of a Solidity DeFi contract and a corresponding test using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract: Simple Lending Pool

This contract allows users to deposit ETH and borrow against their deposits.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleLendingPool {
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public borrows;

    uint256 public constant LTV = 50; // Loan-to-Value ratio in %

    // Deposit ETH into the pool
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        deposits[msg.sender] += msg.value;
    }

    // Borrow ETH up to 50% of deposited amount
    function borrow(uint256 amount) external {
        uint256 maxBorrow = (deposits[msg.sender] * LTV) / 100;
        require(amount <= maxBorrow, "Borrow amount exceeds LTV");
        borrows[msg.sender] += amount;
        payable(msg.sender).transfer(amount);
    }

    // Repay borrowed ETH
    function repay() external payable {
        require(msg.value > 0, "Must repay > 0");
        require(borrows[msg.sender] >= msg.value, "Repay amount exceeds borrow");
        borrows[msg.sender] -= msg.value;
    }

    // Helper function