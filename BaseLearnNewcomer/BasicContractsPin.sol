// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network
 * 5. Deploy your BasicMath - BasicContractsPin.sol Contract
 * 6. After success Deploy go to Deployed Contracts -> copy BasicMath Contract Address
 * 7. go to https://docs.base.org/learn/deployment-to-testnet/deployment-to-testnet-exercise -> Submit Contract Address.
 */


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BasicMath {
    function adder(uint _a, uint _b) public pure returns (uint, bool) {
        unchecked {
            uint sum = _a + _b;
            
            if (sum < _a) {
                return (0, true);
            }
            return (sum, false);
        }
    }

    function subtractor(uint _a, uint _b) public pure returns (uint, bool) {
        if (_b > _a) {
            return (0, true);
        }
        return (_a - _b, false);
    }
}