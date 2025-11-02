// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network
 * 5. at Contract Select AddressBookFactory - NewKeywordPin.sol and Deploy
 * 6. After success Deploy go to Deployed Contracts -> copy AddressBookFactory Contract Address
 * 7. go to https://docs.base.org/learn/new-keyword/new-keyword-exercise -> Submit Contract Address.
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    mapping(uint => Contact) private contacts;
    uint private contactCount;

    error ContactNotFound(uint id);

    constructor() Ownable(msg.sender) {}

    function addContact(
        string memory _firstName,
        string memory _lastName,
        uint[] memory _phoneNumbers
    ) public onlyOwner {
        contacts[contactCount] = Contact(contactCount, _firstName, _lastName, _phoneNumbers);
        contactCount++;
    }

    function deleteContact(uint _id) public onlyOwner {
        if (_id >= contactCount || contacts[_id].id != _id) {
            revert ContactNotFound(_id);
        }
        delete contacts[_id];
    }

    function getContact(uint _id) public view returns (Contact memory) {
        if (_id >= contactCount || contacts[_id].id != _id) {
            revert ContactNotFound(_id);
        }
        return contacts[_id];
    }

    function getAllContacts() public view returns (Contact[] memory) {
        Contact[] memory allContacts = new Contact[](contactCount);
        uint counter = 0;
        for (uint i = 0; i < contactCount; i++) {
            if (contacts[i].id == i) {
                allContacts[counter] = contacts[i];
                counter++;
            }
        }
        return allContacts;
    }
}

contract AddressBookFactory {
    event AddressBookDeployed(address indexed owner, address addressBook);

    function deploy() external returns (address) {
        AddressBook addressBook = new AddressBook();
        emit AddressBookDeployed(msg.sender, address(addressBook));
        return address(addressBook);
    }
}
