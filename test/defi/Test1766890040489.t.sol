Sure! Below is a simple example of a test for a basic DeFi Solidity contract using **Foundry's forge-std** testing framework.

---

### Example Solidity Contract: SimpleVault.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}
```

---

### Test using forge-std (Foundry)

Create a test file `SimpleVault.t.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleVault.sol";  // Adjust path as needed

contract SimpleVaultTest is Test {
    SimpleVault vault;

    address user = address(0x1234);

    function setUp() public {
        vault = new SimpleVault();
        // Label address for readability in logs
        vm.label(user, "User");
    }

    function testDeposit() public {
        // Simulate user depositing 1 ether
        vm.deal(user, 1 ether);  //