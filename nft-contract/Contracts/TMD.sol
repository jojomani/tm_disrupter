pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Mintable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721MetadataMintable.sol";

contract Disrupter is ERC721Full {


    constructor() public ERC721Full("Disrupter", "TMD") { }

    function mintNFT(address to, uint256 tokenId) public returns (bool) {
        _mint(to, tokenId);
        return true;
    }
    
    function registerDisrupter(address client, string memory tokenURI)
        public
        returns (uint256)
    
    { 
        uint256 DisrupterId = totalSupply();
        mintNFT(client, DisrupterId);
        _setTokenURI(DisrupterId, tokenURI);

        return DisrupterId;
    }


}