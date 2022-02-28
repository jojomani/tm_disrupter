pragma solidity ^0.5.5;

import "./TMD_Token.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";


// Have the TMDTokenCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract  TMDTokenCrowdsale is Crowdsale, MintedCrowsale{ 
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate, // rate in TKNbits
        address payable wallet, // sale beneficiary
        TMDToken token, // the TMDToken itself that the  TMDTokenCrowdsale will work with
        uint goal, // the crowdsale goal
        uint open, // the crowdsale opening time
        uint close // the crowdsale closing time
    ) public
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(goal)
        TimedCrowdsale(open, close)
        RefundableCrowdsale(goal)
    {
        // constructor can stay empty
    }
}

contract  TMDTokenCrowdsaleDeployer {
    // Create an `address public` variable called `TMD_token_address`.
    address public TMD_token_address;
    // Create an `address public` variable called `TMD_crowdsale_address`.
    address public TMD_crowdsale_address;
   
    // Add the constructor.
    constructor(
       string memory name,
        string memory symbol,
        address payable wallet, // this address will receive all Ether raised by the sale
        uint goal, 
        uint Now  
    ) public {
        // Create a new instance of the  TMDToken contract.
        TMD_Token token = new TMD_Token(name, symbol, 0);
       
        // Assign the token contract’s address to the `TMD_token_address` variable.
         TMD_token_address = address(token);

        // Create a new instance of the ` TMDTokenCoinCrowdsale` contract
        TMDTokenCrowdsale TMD_crowdsale = new  TMDTokenCrowdsale(1, wallet, token, goal, Now, Now + 12 weeks);
            
        // Aassign the `TMDTokenCrowdsale` contract’s address to the `TMD_crowdsale_address` variable.
        TMD_crowdsale_address = address(TMD_crowdsale);

        // Set the ` TMDTokenCrowdsale` contract as a minter
        token.addMinter(address(TMD_crowdsale));
        
        // Have the ` TMDTokenrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}
