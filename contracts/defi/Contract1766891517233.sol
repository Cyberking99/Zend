```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleLending {
    IERC20 public immutable asset;
    mapping(address => uint256) public deposits;

    constructor(address _asset) {
        asset = IERC20(_asset);
    }

    // Deposit tokens to the contract
    function deposit(uint256 amount) external {
        require(amount > 0, "Zero amount");
        deposits[msg.sender] += amount;
        require(asset.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    // Withdraw deposited tokens
    function withdraw(uint256 amount) external {
        require(amount > 0 && deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        require(asset.transfer(msg.sender, amount), "Transfer failed");
    }
}
```