pragma solidity ^0.8.0;

contract SimpleContract {
    address public owner;
    mapping (address => uint) public balances;
    mapping (address => bool) public isFrozen;

    constructor() public {
        owner = msg.sender;
        balances[owner] = 1000;
        isFrozen[owner] = false;
    }

    function transfer(address recipient, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(!isFrozen[msg.sender], "Account is frozen");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    function freezeAccount(address account) public {
        require(msg.sender == owner, "Only the owner can freeze an account");
        isFrozen[account] = true;
    }

    function unfreezeAccount(address account) public {
        require(msg.sender == owner, "Only the owner can unfreeze an account");
        isFrozen[account] = false;
    }

    function getBalance(address account) public view returns (uint) {
        return balances[account];
    }

    function getFrozenStatus(address account) public view returns (bool) {
        return isFrozen[account];
    }
}
