```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract SimpleLending {
    IERC20 public immutable collateralToken;
    IERC20 public immutable loanToken;

    mapping(address => uint256) public collateralBalance;
    mapping(address => uint256) public loanBalance;

    constructor(address _collateralToken, address _loanToken) {
        collateralToken = IERC20(_collateralToken);
        loanToken = IERC20(_loanToken);
    }

    // Deposit collateral and borrow 50% of its value in loan tokens
    function depositAndBorrow(uint256 collateralAmount) external {
        require(collateralAmount > 0, "Zero collateral");
        collateralToken.transferFrom(msg.sender, address(this), collateralAmount);
        collateralBalance[msg.sender] += collateralAmount;

        uint256 loanAmount = collateralAmount / 2;
        loanBalance[msg.sender] += loanAmount;
        require(loanToken.transferFrom(address(this), msg.sender, loanAmount), "Loan transfer failed");
    }
}
```