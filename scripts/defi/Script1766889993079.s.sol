Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example assumes you have a simple Solidity contract like a basic staking contract, and you want to deploy it to a local or test network.

---

### Example Solidity Contract: `SimpleStaking.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public balances;

    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
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

### Deployment Script using Hardhat (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const SimpleStaking = await ethers.getContractFactory("SimpleStaking");
  const staking = await SimpleStaking.deploy();

  await staking.deployed();

  console.log("SimpleStaking deployed to:", staking.address);
}

main()
  .then(()