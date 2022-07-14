// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Lotterysmartcontact{ 

    //state variables theyll be stored on the blockchain
    address public owner; 
    address payable[] public players; // address and address payable are two differnt types if a contract has to deal with transgfer of ethers then we use address payable.

    constructor(){              // called as soon as we deploy the contract
         owner = msg.sender;    // owner has to be declared in this contract first
    }

    function alreadyentered() view private returns(bool){   //refer to enter function before this function
       for(uint i=0;i < players.length;i++){                
           if(players[i]==msg.sender)                       //checking for the address in the players array 
               return true;                                 //to resrtict person to enter again
           
           return false;
       }
    }
    function enter() public payable{    // function allows to enter players in the lottery
        require (msg.sender != owner,"owner cannot participate!!");  //owner is restricted to enter just to uphold any unfair situations like baised means.
        require(msg.value >= 1 ether,"you atleast have 1 ether to paticipate!!");  // have to pay some ethers to enter the lottery
        require(alreadyentered() == false,"you've already enetered!!"); // players entery prohibited twice
        players.push(payable(msg.sender)); // if the above statements are fullfilled players is pushed in the lottery
    }

    function random() view private returns(uint){     // this is to generate a long random hash number
         return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players))); //this also works with sha256, dont use ripemd160 as its not allowed to convert bytes 20 to uint 256.
    }

    function pickwinner() public  {  // picking the winner using the random ahs generated
        require(msg.sender == owner,"only owner can pick winner"); // only owner can pick winner

// if we  find the modular of this random has it will give a random integer that will be small in number and that number assosaited with the array will be the winner 

        uint index = random() % players.length; 
        players[index].transfer(address(this).balance); // tranfering the balance of the contract to the winner address, adsress(this) is the address of the contact itlsef.
        players =new address payable[](0);  // setting a new lottery with new players after the winner is declared

    }

    function getplayers() view public returns(address payable[] memory){   // to check a player a particular index
        return players;
    }

}
