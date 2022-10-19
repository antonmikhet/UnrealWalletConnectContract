// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./GameDataBase.sol";

contract changeMoney is gameDB {  

    uint public conversionFactor = 314;

   
    modifier onlyOwner {  // Function access modifier, if EuserStatus == ownerContract, you get the rights of the contract owner
      require(users[msg.sender].userStatus == EuserStatus.ownerContract, "you not a owner"); 
      _; 
    }
    

    constructor() {  // The owner of the contract is declared in the constructor
        addUserToContract("Owner", 465684);
        changeUserStatus(msg.sender, EuserStatus.ownerContract);
        owner = msg.sender;
    }



    function getMoneyToConvertation () public payable {  // Function to convert token into game currency and then send it to the blockchain database
            sendToDB(msg.sender, convertationToGameMoney(msg.value), users[msg.sender].userNick );
            
    }

    function convertationToGameMoney (uint _value) internal returns(uint) {  // Mathematical function for converting token into game currency, using the coefficient
        uint value = users[msg.sender].userMoneyAmount + _value *(conversionFactor / 100);
        return value;
    }

    function getContractBalance () public view onlyOwner returns(uint){
        return address(this).balance;
    }

}
    