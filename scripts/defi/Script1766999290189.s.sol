Certainly! Below is a simple example of a deployment script for a basic DeFi Solidity contract using Hardhat. The example includes:

- A minimal Solidity contract (a simple staking contract)
- A deployment script in JavaScript using Hardhat

---

### 1. Solidity Contract (Staking.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStaking {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public stakeTimestamps;

    // Stake tokens by sending Ether
    function stake() external payable {
        require(msg.value > 0, "Must send ETH to stake");
        stakes[msg.sender] += msg.value;
        stakeTimestamps[msg.sender] = block.timestamp;
    }

    // Withdraw staked tokens plus a simple reward
    function withdraw() external {
        uint256 staked = stakes[msg.sender];
        require(staked > 0, "No stakes found");
        
        // Simple reward: 0.1% per day
        uint256 stakingDuration = block.timestamp - stakeTimestamps[msg.sender];
        uint256 reward = (staked * stakingDuration * 1) / (1000 * 1 days);

        stakes[msg.sender] = 0;
        stakeTimestamps[msg.sender] = 0;

        payable(msg.sender).transfer(staked + reward);
    }

    // Check stake + reward (view function)
    function getStakeWith