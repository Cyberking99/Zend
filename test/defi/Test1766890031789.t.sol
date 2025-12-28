Certainly! Below is a simple example of a Solidity test for a basic DeFi contract using **Foundry's `forge-std`** library. The contract is a minimal "Vault" that allows users to deposit and withdraw ETH.

---

### Solidity Contract: `Vault.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    mapping(address => uint256) public balances;

    // Deposit ETH into the vault
    function deposit() external payable {
        require(msg.value > 0, "Must deposit > 0");
        balances[msg.sender] += msg.value;
    }

    // Withdraw ETH from the vault
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test Contract: `Vault.t.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Vault.sol";

contract VaultTest is Test {
    Vault vault;

    function setUp() public {
        vault = new Vault();
    }

    function testDeposit() public {
        // Deposit 1 ether
        vault.deposit{value: 1 ether}();

        // Check balance updated
        assertEq(vault.balances(address(this)), 1 ether);