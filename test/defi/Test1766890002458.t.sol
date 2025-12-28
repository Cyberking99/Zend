Certainly! Below is a simple example of a Solidity DeFi contract and a corresponding test using **Foundry's `forge-std`** framework.

---

### Example DeFi Contract: Simple Lending Pool

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Test Using `forge-std`

Create a test file `SimpleLendingPool.t.sol` in your `test` directory:

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
        // Label the user address for easier debugging
        vm.label