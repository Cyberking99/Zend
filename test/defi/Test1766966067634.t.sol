Sure! Below is a simple example of a Solidity DeFi contract along with a small test using **Foundry's forge-std** framework.

---

### Example Solidity Contract: Simple DeFi Vault

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

    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }
}
```

---

### Test Using Forge-std

Create a test file `SimpleVault.t.sol` under `test/` folder:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleVault.sol";

contract SimpleVaultTest is Test {
    SimpleVault vault;

    address user = address(0x1234);

    function setUp() public {
        vault = new SimpleVault();
    }

    function testDeposit() public {
        vm.deal(user, 1 ether); // Give user 1 ETH

        vm.pr