pragma solidity ^0.8.0;

contract SimpleContract {
    address public owner;
    mapping (address => uint) public balances;

    constructor() public {
        owner = msg.sender;
        balances[owner] = 1000;
    }

    function transfer(address recipient, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }

    function getBalance(address account) public view returns (uint) {
        return balances[account];
    }
}
