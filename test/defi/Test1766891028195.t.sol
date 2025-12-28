Certainly! Below is a small example of a Solidity test using **Foundry's `forge-std`** library. I'll create a simple DeFi contract (a minimal staking contract) and a test for it.

---

### Example DeFi Contract: Simple Staking

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Forge Test Using `forge-std`

Create a test file under `test/SimpleStaking.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleStaking.sol";

contract SimpleStakingTest is Test {
    SimpleStaking staking;

    address user = address(0x1234);

    function setUp() public {
        staking = new SimpleStaking();
    }

    function testStakeIncreasesBalance