Certainly! Below is a simple example of a Solidity test using **Foundry's** `forge-std` library. The example assumes a basic DeFi contract, such as a simple staking contract, and tests a deposit function.

---

### Example Solidity contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Test using Foundry (`forge-std`)

Create a test file `SimpleStaking.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleStaking.sol";

contract SimpleStakingTest is Test {
    SimpleStaking staking;

    function setUp() public {
        staking = new SimpleStaking();
    }

    function testDeposit() public {
        // Arrange
        uint256 depositAmount = 1 ether;

        // Act
        staking.deposit{value: depositAmount}();

        // Assert
        uint256 balance = staking.getBalance(address(this));
        assertEq(balance, depositAmount