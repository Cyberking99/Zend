Certainly! Below is a simple example of a Solidity DeFi contract and a small test written using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract: Simple Lending Pool

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLendingPool {
    mapping(address => uint256) public balances;

    // Deposit ETH into the pool
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the pool
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Get the balance of the sender
    function myBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### Test using forge-std

Create a test file `SimpleLendingPool.t.sol` inside your `test/` directory:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleLendingPool.sol";

contract SimpleLendingPoolTest is Test {
    SimpleLendingPool pool;

    function setUp() public {
        pool = new SimpleLendingPool();