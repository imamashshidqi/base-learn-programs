// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network
 * 5. Deploy your UnburnableToken - MinimalTokenPin.sol Contract
 * 6. After success Deploy go to Deployed Contracts -> copy UnburnableToken Contract Address
 * 7. go to https://docs.base.org/learn/arrays/arrays-exercise -> Submit Contract Address.
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnburnableToken {
    string private salt = "value";
    mapping(address => uint256) public balances;

    uint256 public totalSupply;
    uint256 public totalClaimed;
    mapping(address => bool) private claimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    constructor() {
        totalSupply = 100000000;
    }

    function claim() public {
        if (totalClaimed >= totalSupply) revert AllTokensClaimed();
        if (claimed[msg.sender]) revert TokensClaimed();

        balances[msg.sender] += 1000;
        totalClaimed += 1000;
        claimed[msg.sender] = true;
    }

    function safeTransfer(address _to, uint256 _amount) public {
        if (_to == address(0) || _to.balance == 0) revert UnsafeTransfer(_to);
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}