Sure! Below is a simple example of a Solidity test using **forge-std** (Foundry's standard library) for a basic DeFi contract. I'll create a minimal DeFi contract (e.g., a simple lending pool) and write a test that deposits and withdraws funds.

---

### Step 1: Example DeFi contract (SimpleLendingPool.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleLendingPool {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Step 2: Forge test using forge-std (SimpleLendingPool.t.sol)

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
        // Label the user address for easier debugging