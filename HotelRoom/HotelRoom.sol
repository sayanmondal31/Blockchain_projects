// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
     // Topics to cover
    // Ether payments - how to pay in crypto currencies
    // Modifiers 
    // Visibility
    // Events
    // Enums

    enum Statuses {
        Vacant, 
        Occupied
    }

    Statuses public  currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;  // this is the state variable, public is for read varibale outside smart contract
    // payble is modifier that let address actually receive etherium crypto currencies
 
    constructor() {  // this runs only once when the contract created
        owner = payable(msg.sender); 
        currentStatus = Statuses.Vacant;
    } 
        // msg is gobal variable inside solidity and sender is the property that tells who is calling this function
    // and also who deployed contract to blockchain

    modifier onlyWhileVacant {
        // check status
        require(currentStatus == Statuses.Vacant,"Currently occupied!"); // this will conatain condtions if condition is true then will execute lines
        _; // return function code
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount,"Not enough ether provided");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;

        // owner.transfer(msg.value); // transfer - it sends crypto currency to receipient in this case owner
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);
        emit Occupy(msg.sender, msg.value);
    }

}