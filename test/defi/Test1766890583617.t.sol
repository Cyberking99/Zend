Certainly! Below is a simple example of a Solidity test for a basic DeFi contract using **Foundry's forge-std** testing framework.

---

### Example DeFi Contract (SimpleVault.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVault {
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Helper function to get contract balance
    function totalBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### Test Using Forge-Std (SimpleVault.t.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleVault.sol";

contract SimpleVaultTest is Test {
    SimpleVault vault;

    address user = address(0x1234);

    function set