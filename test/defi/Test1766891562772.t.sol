Sure! Below is a simple example of a Solidity test using **forge-std** (Foundry). This example assumes you have a basic DeFi contract, for instance, a simple staking contract where users can stake and withdraw tokens.

---

### Sample Solidity Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public stakes;

    function stake() external payable {
        require(msg.value > 0, "Must stake > 0");
        stakes[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Not enough staked");
        stakes[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getStake(address user) external view returns (uint256) {
        return stakes[user];
    }
}
```

---

### Test using Forge (Foundry) with forge-std

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Staking.sol";

contract StakingTest is Test {
    Staking staking;

    address user = address(0x1234);

    function setUp() public {
        staking = new Staking();
        // Give user some ETH to work with
        vm.deal(user, 10 ether);
    }