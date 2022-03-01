pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract TM_Disruptor_Token is ERC20, ERC20Detailed {
     // that code makes any purchases in the contract redeemable by the owner
    address payable owner;
    // this code is to allow us and us only the owner of the smart contract to create or mint new token
    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }
    // this code allow us to create the initial total supply of our token 
    constructor(uint initial_supply) ERC20Detailed("TM_disruptor", "TMD", 18) public {
        owner = msg.sender;
        _mint(owner, initial_supply);
    }

    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }
}
