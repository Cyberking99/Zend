```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleLending {
    IERC20 public immutable stablecoin;
    mapping(address => uint256) public deposits;

    constructor(address _stablecoin) {
        stablecoin = IERC20(_stablecoin);
    }

    // User deposits stablecoin into the contract
    function deposit(uint256 amount) external {
        require(amount > 0, "Zero amount");
        deposits[msg.sender] += amount;
        require(stablecoin.transferFrom(msg.sender, address(this), amount), "Transfer failed");
    }

    // User withdraws their deposited stablecoin
    function withdraw(uint256 amount) external {
        require(amount > 0 && deposits[msg.sender] >= amount, "Invalid amount");
        deposits[msg.sender] -= amount;
        require(stablecoin.transfer(msg.sender, amount), "Transfer failed");
    }
}
```