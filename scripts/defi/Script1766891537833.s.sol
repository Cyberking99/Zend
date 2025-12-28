Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using **Hardhat** and **ethers.js**. This script deploys a simple ERC20 token contract which could be part of a DeFi protocol.

---

### Example Solidity Contract: `MyToken.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply);
    }
}
```

---

### Deployment Script: `deploy.js`

```javascript
async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const initialSupply = ethers.utils.parseUnits("1000000", 18); // 1,000,000 tokens with 18 decimals

  const MyToken = await ethers.getContractFactory("MyToken");
  const myToken = await MyToken.deploy(initialSupply);

  await myToken.deployed();

  console.log("MyToken deployed to:", myToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
```

---

### How to Run

1. Initialize a Hardhat project