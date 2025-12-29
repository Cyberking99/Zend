Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. This script assumes you have a simple Solidity contract (e.g., a basic ERC20 token or a staking contract) and want to deploy it to a local or test network.

---

### Example Solidity Contract: `SimpleToken.sol`

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SimpleToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("SimpleToken", "STKN") {
        _mint(msg.sender, initialSupply);
    }
}
```

---

### Deployment Script Using Hardhat: `scripts/deploy.js`

```javascript
async function main() {
  // Get the contract factory
  const SimpleToken = await ethers.getContractFactory("SimpleToken");

  // Define initial supply (e.g., 1 million tokens with 18 decimals)
  const initialSupply = ethers.utils.parseEther("1000000");

  // Deploy the contract
  const simpleToken = await SimpleToken.deploy(initialSupply);

  // Wait for deployment to finish
  await simpleToken.deployed();

  console.log("SimpleToken deployed to:", simpleToken.address);
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