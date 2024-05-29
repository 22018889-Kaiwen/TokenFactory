// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Token {
    string public symbol;
    string public name;
    uint8 public decimals;
    uint public totalSupply;

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );
    event Mint(address indexed to, uint tokens);
    event Burn(address indexed from, uint tokens);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10 ** uint(decimals);
        balances[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        require(to != address(0)); // Prevent transferring to 0x0 address
        require(balances[msg.sender] >= tokens); // Check if the sender has enough tokens
        balances[msg.sender] -= tokens; // Deduct tokens from sender's balance
        balances[to] += tokens; // Add tokens to recipient's balance
        emit Transfer(msg.sender, to, tokens); // Emit transfer event
        return true;
    }

    function approve(
        address spender,
        uint tokens
    ) public returns (bool success) {
        allowed[msg.sender][spender] = tokens; // Set allowance
        emit Approval(msg.sender, spender, tokens); // Emit approval event
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint tokens
    ) public returns (bool success) {
        require(from != address(0)); // Prevent transferring from 0x0 address
        require(to != address(0)); // Prevent transferring to 0x0 address
        require(tokens <= balances[from]); // Check if the sender has enough tokens
        require(tokens <= allowed[from][msg.sender]); // Check allowance
        balances[from] -= tokens; // Deduct tokens from sender's balance
        balances[to] += tokens; // Add tokens to recipient's balance
        allowed[from][msg.sender] -= tokens; // Deduct allowance from sender's allowance
        emit Transfer(from, to, tokens); // Emit transfer event
        return true;
    }

    function allowance(
        address tokenOwner,
        address spender
    ) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function mint(address to, uint tokens) public onlyOwner returns (bool) {
        totalSupply += tokens; // Increase total supply
        balances[to] += tokens; // Add tokens to recipient's balance
        emit Mint(to, tokens); // Emit mint event
        emit Transfer(address(0), to, tokens); // Emit transfer event
        return true;
    }

    function burn(uint tokens) public returns (bool) {
        require(balances[msg.sender] >= tokens); // Check if the sender has enough tokens
        totalSupply -= tokens; // Decrease total supply
        balances[msg.sender] -= tokens; // Deduct tokens from sender's balance
        emit Burn(msg.sender, tokens); // Emit burn event
        emit Transfer(msg.sender, address(0), tokens); // Emit transfer event
        return true;
    }
}
