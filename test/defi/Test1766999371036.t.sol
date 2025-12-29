Sure! Below is a simple example of a Solidity test for a basic DeFi contract using **Foundry's forge-std** library. The example includes a minimal DeFi contract (a simple lending pool) and a test contract that tests deposit and withdrawal functionality.

---

### Example DeFi Contract: SimpleLendingPool.sol

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

### Test Contract using forge-std (Foundry)

Create a test file `SimpleLendingPool.t.sol`:

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
        vm.deal(user, 10 ether); // give user