Sure! Below is a simple example of a Solidity smart contract for a basic DeFi-like contract (a simple staking contract), and a small test written using **Foundry (forge-std)**.

---

### Solidity contract: `SimpleStaking.sol`

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
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Foundry test: `SimpleStaking.t.sol`

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

    function testStakeIncreasesBalance() public {
        uint256 stakeAmount = 1 ether;

        // Call stake with 1 ether
        staking