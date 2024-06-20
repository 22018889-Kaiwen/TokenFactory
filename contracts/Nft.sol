// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Nft is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC721(name, symbol) Ownable(initialOwner) {
        _tokenIdCounter = 1;
    }

    function mintNFT(
        address to,
        string memory tokenURI
    ) external onlyOwner returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        _tokenIdCounter++;
        return tokenId;
    }

    function nextTokenId() public view returns (uint256) {
        return _tokenIdCounter;
    }
}
