// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Token.sol";

contract Factory {
    event TokenDeployed(address indexed tokenAddress);

    function deployToken(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) public {
        Token token = new Token(_name, _symbol, _decimals, _initialSupply);
        emit TokenDeployed(address(token));
    }
}
