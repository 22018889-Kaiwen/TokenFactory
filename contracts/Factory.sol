// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Token.sol";

contract Factory {
    address public owner;

    event TokenDeployed(address indexed tokenAddress);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
    }

    function deployToken(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) public {
        Token token = new Token(
            _name,
            _symbol,
            _decimals,
            _initialSupply,
            msg.sender,
            address(this)
        );
        emit TokenDeployed(address(token));
    }

    function mintToken(
        address tokenAddress,
        address to,
        uint tokens
    ) public onlyOwner {
        Token(tokenAddress).mint(to, tokens);
    }

    function burnToken(address tokenAddress, uint tokens) public onlyOwner {
        Token(tokenAddress).burn(tokens);
    }

    function transferToken(
        address tokenAddress,
        address to,
        uint tokens
    ) public returns (bool success) {
        return Token(tokenAddress).transfer(to, tokens);
    }

    function approveToken(
        address tokenAddress,
        address spender,
        uint tokens
    ) public returns (bool success) {
        return Token(tokenAddress).approve(spender, tokens);
    }

    function transferTokenFrom(
        address tokenAddress,
        address from,
        address to,
        uint tokens
    ) public returns (bool success) {
        return Token(tokenAddress).transferFrom(from, to, tokens);
    }

    function allowanceToken(
        address tokenAddress,
        address tokenOwner,
        address spender
    ) public view returns (uint remaining) {
        return Token(tokenAddress).allowance(tokenOwner, spender);
    }

    function balanceOfToken(
        address tokenAddress,
        address tokenOwner
    ) public view returns (uint balance) {
        return Token(tokenAddress).balanceOf(tokenOwner);
    }
}
