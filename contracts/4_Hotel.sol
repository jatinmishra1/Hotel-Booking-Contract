// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Hotel{
    address payable public owner;
    enum Stateuses {Vacant,Occupied} 
    Stateuses currenState;
    constructor(){
        owner=payable (msg.sender);
        currenState=Stateuses.Vacant;
    }

    modifier onlyWhileVacant{
require(currenState==Stateuses.Vacant,"Already acquired");
_;
    }

        modifier minimumEtherRequired(uint _amount){
require(msg.value>=_amount,"Not enough Ether available");
_;
    }

    receive() external payable  onlyWhileVacant minimumEtherRequired(2 ether)  {
        
         require(msg.sender != owner, "Owner cannot send money");
        owner.transfer(msg.value);
        currenState=Stateuses.Occupied;
    }

    
}