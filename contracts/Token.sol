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
    address public factory;

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint tokens
    );
    event Mint(address indexed to, uint tokens);
    event Burn(address indexed from, uint tokens);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyFactory() {
        require(
            msg.sender == factory,
            "Only the factory can call this function"
        );
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        address _owner,
        address _factory
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10 ** uint(_decimals);
        balances[_owner] = totalSupply;
        owner = _owner;
        factory = _factory;
        emit Transfer(address(0), _owner, totalSupply);
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        require(to != address(0), "Cannot transfer to the zero address");
        require(balances[msg.sender] >= tokens, "Insufficient balance");
        balances[msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(
        address spender,
        uint tokens
    ) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint tokens
    ) public returns (bool success) {
        require(from != address(0), "Cannot transfer from the zero address");
        require(to != address(0), "Cannot transfer to the zero address");
        require(tokens <= balances[from], "Insufficient balance");
        require(tokens <= allowed[from][msg.sender], "Allowance exceeded");
        balances[from] -= tokens;
        balances[to] += tokens;
        allowed[from][msg.sender] -= tokens;
        emit Transfer(from, to, tokens);
        return true;
    }

    function allowance(
        address tokenOwner,
        address spender
    ) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function mint(
        address to,
        uint tokens
    ) public onlyOwner returns (bool success) {
        totalSupply += tokens;
        balances[to] += tokens;
        emit Mint(to, tokens);
        emit Transfer(address(0), to, tokens);
        return true;
    }

    function burn(uint tokens) public onlyOwner returns (bool success) {
        require(balances[msg.sender] >= tokens, "Insufficient balance");
        totalSupply -= tokens;
        balances[msg.sender] -= tokens;
        emit Burn(msg.sender, tokens);
        emit Transfer(msg.sender, address(0), tokens);
        return true;
    }
}
