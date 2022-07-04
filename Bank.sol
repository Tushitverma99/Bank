pragma solidity >=0.7.0 <0.9.0;

contract SmartBankAccount {

    uint totalContractBalance;

    function getContractBalance() public view returns(uint){
        return totalContractBalance;
    }
    
    mapping(address => uint) balances;
    mapping(address => uint) depositTimestamps;
    
    function addBalance() public payable {
        balances[msg.sender] = msg.value;
        totalContractBalance = totalContractBalance + msg.value;
        depositTimestamps[msg.sender] = block.timestamp;
    }
    
    function getBalance(address userAddress) public view returns(uint) {
        uint principal = balances[userAddress];
        uint timeElapsed = block.timestamp - depositTimestamps[userAddress]; //seconds
        return principal + uint((principal * 7 * timeElapsed) / (100 * 365 * 24 * 60 * 60)) + 1; //simple interest of 0.07%  per year
    }
    
    function withdraw(uint _amount) public payable {
        address payable withdrawTo = payable(msg.sender);
        uint amount = _amount;
        withdrawTo.transfer(amount);
        totalContractBalance = totalContractBalance - amount;
        balances[msg.sender] = balances[msg.sender] - amount;
    }
    
    function addMoneyToContract() public payable {
        totalContractBalance += msg.value;
    }

    
}