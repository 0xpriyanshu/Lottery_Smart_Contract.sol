// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract VendingMachine{

// state variable: the below mwntioned things are going to be stored in blockchain.
    address public owner;
    mapping(address => uint) public donutbalance;

// Constructor is used here set the owner to the person wo deploys this contract and to set tyhe inital amount of donuts in the vending machine.
    constructor(){         // constructor generates a getter function on its own so youll get owner and donut balance after deploying.
        owner = msg.sender;
        donutbalance[address(this)]=100; //Initial amount of donut in vending machine is 100
            }
// Do not confuse between msg.sender and adress(this).
// msg.sender = address of the person calling the contract.
// address(this) = adrdress of the contract itself.
// now its time to write functions of this contract so we are going to perform three functions ie purchase, restock, check the donut balance.


// Purchase

    function purchase(uint _amount)public payable{ //any tranactional function should be made payable.
        require (msg.value >= _amount * 2 ether, "you should atleast have 2 ether to buy donut"); // min amount is 2 ether bec min donuttaht could be purchase is 1.
        require (donutbalance[address(this)] >= _amount,"sorry! Insufficient donuts to fullfill purchase"); // checking if sufficient the dionuts are there 
        donutbalance[address(this)] -= _amount;  // decrementing the donut number from the owner or vendor.
        donutbalance[address(msg.sender)] += _amount; // incrementing the donut numner to the person purchasing it.
    }

// Restock function   

    function restock(uint _amount)public {
        require (owner == msg.sender, "only owner can restock the vneding machine."); // owner ie the person who deploys the contact can only restck the donuts in the vending machine.
        donutbalance[address(this)] += _amount; // Incrementing the amount ie to be restock.
    }    

//Check balance function

    function getvendingamachinebalance() public view returns(uint){
        return donutbalance[address(this)];
    }
}


