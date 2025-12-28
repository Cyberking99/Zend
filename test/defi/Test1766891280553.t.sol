Certainly! Below is a small example of a Solidity DeFi contract and a corresponding test using **Foundry's** `forge-std` testing framework.

---

### Simple DeFi Contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Test for `SimpleBank` using Foundry (`forge-std`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/SimpleBank.sol";

contract SimpleBankTest is Test {
    SimpleBank bank;

    address user = address(0x1234);

    function setUp() public {
        bank