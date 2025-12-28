Certainly! Below is a simple deployment script using Hardhat for a basic DeFi Solidity contract. The example contract is a minimal "SimpleBank" that allows users to deposit and withdraw Ether.

---

### 1. Solidity contract: `SimpleBank.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit positive amount");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
```

---

### 2. Deployment script: `scripts/deploy.js`

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with account:", deployer.address);

  const SimpleBank = await ethers.getContractFactory("SimpleBank");
  const bank = await SimpleBank.deploy();

  await bank.deployed