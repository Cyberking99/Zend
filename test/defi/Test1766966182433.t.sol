Certainly! Below is a simple example of a Solidity test using **Foundry's forge-std** library. This example assumes you have a basic DeFi contract, for example, a simple `Vault` contract that allows deposits and withdrawals of Ether.

---

### Example Solidity Contract: `Vault.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vault {
    mapping(address => uint256) public balances;

    // Deposit Ether into the vault
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the vault
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test Using Forge (`Vault.t.sol`)

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
        assertEq(vault.balances(address(this)),