Certainly! Below is a simple example of a Solidity DeFi contract and a corresponding test using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract: Simple Lending Pool

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleLendingPool {
    mapping(address => uint256) public deposits;

    // Deposit ETH into the pool
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        deposits[msg.sender] += msg.value;
    }

    // Withdraw ETH from the pool
    function withdraw(uint256 amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Check balance of user
    function balanceOf(address user) external view returns (uint256) {
        return deposits[user];
    }
}
```

---

### Forge Test Using `forge-std`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/SimpleLendingPool.sol";

contract SimpleLendingPoolTest is Test {
    SimpleLendingPool pool;
    address user = address(0x1234);

    function setUp() public {
        pool = new SimpleLendingPool();
        // Fund user with some ETH for testing