pragma solidity ^0.4.21;

import "../ERC20Interface.sol";

contract WitchToken is ERC20Interface {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public initialSupply;
    
    mapping (address => uint256) balances;
    mapping (address => mapping(address => uint256)) allowed;
    
    function totalSupply() public view returns (uint) {
        return initialSupply - balances[0];
    }
    
    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }
    
    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }
    
    function transfer(address to, uint tokens) public returns (bool success) {
        require(balances[msg.sender] >= tokens);
        require(tokens >= 0);
        
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    
    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    
    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        require(balances[from] >= tokens);
        require(allowed[from][msg.sender] >= tokens);
        require(tokens >= 0);
        
        balances[from] = balances[from] - tokens;
        allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
        balances[to] = balances[to] + tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
}