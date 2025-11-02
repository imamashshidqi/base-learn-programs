// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network
 * 5. Deploy your EmployeeStorage - StoragePin.sol Contract
 * 6. After success Deploy go to Deployed Contracts -> copy EmployeeStorage Contract Address
 * 7. go to https://docs.base.org/learn/storage/storage-exercise -> Submit Contract Address.
 */

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

contract EmployeeStorage {
    string public name;
    uint public idNumber;

    uint24 private salary;
    uint16 private shares;

    constructor() {
        name = "Pat";
        idNumber = 123456789;
        salary = 50000;
        shares = 1000;
    }

    function grantShares(uint16 _newShares) external {
        require(_newShares <= 5000, "Too many shares");
        shares += _newShares;
    }

    function checkForPacking(uint _slot) external view returns (uint result) {
        assembly {
            result := sload(_slot)
        }
    }

    function viewShares() external view returns (uint16) {
        return shares;
    }

    function viewSalary() external view returns (uint24) {
        return salary;
    }

    function debugResetShares() external {
        shares = 1000;
    }
}