pragma solidity 0.5.3;

contract escrow_ssafy{
    
    uint public value;
    address payable public seller;
    address payable public buyer;
    enum State {Null, Regist, CompletePay, Delivery, Complete, Locked}
    State public state;
    
    mapping(address=> uint) balanceOf;
    
    constructor() public{
        state = State.Null;
    }
    
    function registrItem(uint amount)public returns(uint){
        seller = msg.sender;
        value = amount;
        
        state = State.Regist;
        
        return 1;
    }
    
    function buyItem() payable public returns(uint){
        buyer = msg.sender;
        balanceOf[seller] += value;
        
        state = State.CompletePay;
        
        return 2;
    }
    
    function confirmItem() public returns(uint){
        
        selfdestruct(seller);
        
        state = State.Complete;
        
        return 4;
    }
    
    function sendItem() public returns(uint){
        
        state = State.Delivery;
        
        return 3;
    }
    
    function siren() public returns(uint){
        
        state = State.Locked;
        
        return 5;
    }
    
    function exit(uint result) public returns(uint){
        if(result == 1){
            selfdestruct(buyer);
            
            return 6;
        }else{
            selfdestruct(seller);
            
            return 7;
        }
    }
    
}