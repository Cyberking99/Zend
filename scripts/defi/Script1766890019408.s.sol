Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This example assumes you have a simple `Token` contract (an ERC20 token) that you want to deploy.

---

### Example Solidity Contract (`Token.sol`)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }
}
```

---

### Deployment Script (`scripts/deploy.js`)

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const initialSupply = ethers.utils.parseEther("1000"); // 1000 tokens with 18 decimals

  const Token = await ethers.getContractFactory("Token");
  const token = await Token.deploy(initialSupply);

  await token.deployed();

  console.log("Token deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

---

### How to run:

1. Make sure you have Hardhat installed and initialized:

```bash
npm install --save-dev hardhat @nomic