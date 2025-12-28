Certainly! Below is a simple example of a Solidity test using **Foundry's forge-std** for a basic DeFi contract. The contract is a minimal example of a simple staking contract where users can stake ETH and withdraw it later.

---

### Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
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

### Forge Test: `SimpleStaking.t.sol`

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
        // User address to simulate
        address user = address(1);