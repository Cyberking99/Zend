Sure! Below is a simple example of a Solidity test using **Foundry's `forge-std`** library for a basic DeFi contract. I'll create a minimal DeFi contract (a simple staking contract) and then write a test for it.

---

### Example DeFi Contract: Simple Staking

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public balances;
    uint256 public totalStaked;

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        balances[msg.sender] += msg.value;
        totalStaked += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test Using Forge (`forge-std`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./SimpleStaking.sol";

contract SimpleStakingTest is Test {
    SimpleStaking staking;

    function setUp() public {
        staking = new SimpleStaking();
    }

    function testStakeIncreasesBalanceAndTotal() public {
        uint256 stakeAmount = 1 ether;

        //