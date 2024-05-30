// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Token.sol";

contract TokenFactory {
    event TokenCreated(
        address indexed tokenAddress,
        string name,
        string symbol
    );

    function createToken(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) external returns (address) {
        Token newToken = new Token(
            _name,
            _symbol,
            _decimals,
            _initialSupply,
            msg.sender,
            address(this)
        );
        emit TokenCreated(address(newToken), _name, _symbol);
        return address(newToken);
    }
}
