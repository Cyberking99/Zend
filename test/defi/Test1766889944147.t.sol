Sure! Here's a small example of a test for a simple DeFi Solidity contract using **Foundry's forge-std** testing framework.

---

### Example Solidity Contract: SimpleVault.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVault {
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Deposit zero");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
}
```

---

### Forge Test: SimpleVault.t.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleVault.sol";

contract SimpleVaultTest is Test {
    SimpleVault vault;

    function setUp() public {
        vault = new SimpleVault();
    }

    function testDeposit() public {
        // Deposit 1 ether
        vm.deal(address(this), 1 ether); // give contract 1 ether to send
        vault.deposit{