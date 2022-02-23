pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract Disrupter is ERC721Full {
    constructor() public ERC721Full("Disrupter", "TMD") { }

    function registerDisrupter(address client, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 DisrupterId = totalSupply();
        _mint(client, DisrupterId);
        _setTokenURI(DisrupterId, tokenURI);

        return DisrupterId;
    }
}