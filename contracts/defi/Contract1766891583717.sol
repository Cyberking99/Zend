```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleDeFi {
    IERC20 public immutable stakingToken;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public rewardDebt;
    uint256 public accRewardPerToken; // scaled by 1e18
    uint256 public totalStaked;
    uint256 public constant REWARD_RATE = 1e16; // 0.01 token per block

    constructor(address _stakingToken) {
        stakingToken = IERC20(_stakingToken);
    }

    function stake(uint256 amount) external {
        updateRewards();
        if (balances[msg.sender] > 0) {
            uint256 pending = (balances[msg.sender] * accRewardPerToken) / 1e18 - rewardDebt[msg.sender];
            if (pending > 0) {
                stakingToken.transfer(msg.sender, pending);
            }
        }
        stakingToken.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
        totalStaked += amount;
        rewardDebt[msg.sender] = (balances[msg.sender] * accRewardPerToken) / 1e18;
    }

    function updateRewards() public {
        if (totalStaked == 0) return;
        uint256 blocks = block.number - lastRewardBlock;
        uint256 reward = blocks *