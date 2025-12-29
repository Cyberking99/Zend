Certainly! Below is a simple example of a Solidity test using **forge-std** with Foundry for a basic DeFi contract. The example assumes you have a simple DeFi contract like a basic staking contract.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    uint256 public totalStaked;

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        stakes[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test Using Forge-Std (Foundry)

Save this as `SimpleStaking.t.sol` in your `test` folder:

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

    function testInitialState() public {
        assertEq(staking