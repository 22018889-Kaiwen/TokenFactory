// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Nft.sol";

contract NftFactory {
    event TokenCreated(address tokenAddress);
    event NFTMinted(
        address indexed tokenAddress,
        address indexed to,
        uint256 indexed tokenId,
        string tokenURI
    );

    function deployToken(
        string memory name,
        string memory symbol
    ) public returns (address) {
        Nft nftContract = new Nft(name, symbol, msg.sender);
        emit TokenCreated(address(nftContract));
        return address(nftContract);
    }

    function mintNFT(
        address tokenAddress,
        address to,
        string memory tokenURI
    ) public returns (bool) {
        Nft nftContract = Nft(tokenAddress);
        uint256 tokenId = nftContract.mintNFT(to, tokenURI);
        emit NFTMinted(tokenAddress, to, tokenId, tokenURI);
        return true;
    }
}
