Certainly! Below is a simple example of a Solidity DeFi contract and a small test suite for it using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract: Simple Lending Pool

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLendingPool {
    mapping(address => uint256) public deposits;

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        deposits[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getDeposit(address user) external view returns (uint256) {
        return deposits[user];
    }
}
```

---

### Test Using Forge-Std

Create a test file `SimpleLendingPool.t.sol` in your `test` folder:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleLendingPool.sol";

contract SimpleLendingPoolTest is Test {
    SimpleLendingPool pool;

    address user = address(0x1234);

    function setUp() public {
        pool = new SimpleLendingPool();
        // Fund user with some ETH for testing
        vm