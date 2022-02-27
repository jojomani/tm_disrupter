pragma solidity ^0.7.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MyNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public ERC721("MyNFT", "NFT") {}

    function mintNFT(address recipient, string memory tokenURI)
        public onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}

contract Disrupter is ERC721Full, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


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