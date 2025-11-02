// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network
 * 5. Deploy your HaikuNFT - SCDERC721Pin.sol Contract
 * 6. After success Deploy go to Deployed Contracts -> copy HaikuNFT Contract Address
 * 7. go to https://docs.base.org/learn/arrays/arrays-exercise -> Submit Contract Address.
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

interface ISubmission {
    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    function mintHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external;

    function counter() external view returns (uint256);

    function shareHaiku(uint256 _id, address _to) external;

    function getMySharedHaikus() external view returns (Haiku[] memory);
}

contract HaikuNFT is ERC721, ISubmission {
    Haiku[] public haikus;
    mapping(address => mapping(uint256 => bool)) public sharedHaikus;
    mapping(bytes32 => bool) private usedLines; // <- cek per line
    uint256 public override counter;

    constructor() ERC721("HaikuNFT", "HAIKU") {}

    function mintHaiku(
        string memory _line1,
        string memory _line2,
        string memory _line3
    ) external override {
        // cek tiap baris unik
        if (usedLines[keccak256(bytes(_line1))]) revert HaikuNotUnique();
        if (usedLines[keccak256(bytes(_line2))]) revert HaikuNotUnique();
        if (usedLines[keccak256(bytes(_line3))]) revert HaikuNotUnique();

        // tandai semua baris sudah dipakai
        usedLines[keccak256(bytes(_line1))] = true;
        usedLines[keccak256(bytes(_line2))] = true;
        usedLines[keccak256(bytes(_line3))] = true;

        _safeMint(msg.sender, counter);
        haikus.push(Haiku(msg.sender, _line1, _line2, _line3));
        counter++;
    }

    function shareHaiku(uint256 _id, address _to) external override {
        require(_id < counter, "Invalid haiku ID");
        require(haikus[_id].author == msg.sender, "NotYourHaiku");
        sharedHaikus[_to][_id] = true;
    }

    function getMySharedHaikus()
        external
        view
        override
        returns (Haiku[] memory)
    {
        uint256 sharedCount;
        for (uint256 i = 0; i < haikus.length; i++) {
            if (sharedHaikus[msg.sender][i]) sharedCount++;
        }
        if (sharedCount == 0) revert NoHaikusShared();

        Haiku[] memory result = new Haiku[](sharedCount);
        uint256 index;
        for (uint256 i = 0; i < haikus.length; i++) {
            if (sharedHaikus[msg.sender][i]) {
                result[index] = haikus[i];
                index++;
            }
        }
        return result;
    }

    // Errors
    error HaikuNotUnique();
    error NoHaikusShared();
    error NotYourHaiku();
}

