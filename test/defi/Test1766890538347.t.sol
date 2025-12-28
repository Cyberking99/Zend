Certainly! Below is a simple example of a Solidity test using **Foundry's forge-std** testing library. We'll create a minimal DeFi contract (a simple staking contract) and write a test to verify staking and withdrawal functionality.

---

### 1. Minimal DeFi Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint256) public balances;

    function stake() external payable {
        require(msg.value > 0, "Must stake some ETH");
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

### 2. Forge Test (Staking.t.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Staking.sol";

contract StakingTest is Test {
    Staking public staking;

    address user = address(0x1234);

    function setUp() public {
        staking = new Staking();
        // Fund user with 10 ETH for testing
        vm.deal(user, 10