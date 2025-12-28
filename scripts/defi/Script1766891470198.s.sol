Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script assumes you have a Solidity contract named `SimpleDeFi.sol` that you want to deploy to a local or test Ethereum network.

---

### Example Solidity Contract: `SimpleDeFi.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleDeFi {
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    // Deposit ETH into the contract
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw ETH from the contract
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // Get contract balance
    function contractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
```

---

### Deployment Script: `scripts/deploy.js`

```javascript
async function main() {
  // Get the contract factory
  const SimpleDeFi = await ethers.getContractFactory("Simple