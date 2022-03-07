# Tm_disrupter
## Project Overview

For this porject we created a NFT to launch ticketing system with smart contract that is deployed to use on website and imported into Opensea (Market for NFT's, buy and sell). Our target market currently are major events such as basketball games or world cup.

---

## Technologies

The application is in python and is using the following libraries:

* [React](https://reactjs.org/) - JavaScript library for building user interfaces.

* [Metamask](https://metamask.io/) - crypto wallet & gateway to blockchain apps.

* [Web3](https://ethereum.org/en/developers/docs/web2-vs-web3/) - is a collection of JS libraries that lets you interact with an Ethereum node remotely or locally.

* [SmartContract](https://ethereum.org/en/developers/tutorials/how-to-mint-an-nft/) -“Minting an NFT” is the act of publishing a unique instance of your ERC-721 token on the blockchain.

* [Rinkeby](https://www.rinkeby.io/#stats) - Rinkeby is an Ethereum test network that allows for blockchain development testing before deployment on Mainnet, the main Ethereum network.

* [Token Crowdsale](https://docs.openzeppelin.com/contracts/2.x/crowdsales) - type of crowdfunding that issues tokens (electronic records) that are stored on the user's device.

* [Adobe Photoshop](https://www.adobe.com/products/photoshop.html) - Photoshop is your go-to application for working with pixel-based images designed for print, web, and mobile apps.

* [Canvas]-(https://www.canva.com/logos/) Canva's logo maker provides tools to create a custom logo.

* [Heroku](https://www.heroku.com/) - is a container-based cloud Platform as a Service (PaaS). We used Heroku to deploy, manage, and scale modern apps.

* [Pinata](https://www.pinata.cloud/) -  the simplest way to upload and manage files on IPFS

* [Remix](https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null) - Remix IDE is an open source web and desktop application.



The operating system used in creating the application is Windows 10 64 bit. 

There are many few versions of TMD NFD in the upload. There are files for logos, web-ui and NFT contract files.

Example of some code is listed below:

```python
contract ERC721 is Context, ERC165, IERC721, IERC721Metadata {
    using Address for address;
    using Strings for uint256;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Mapping from token ID to owner address
    mapping(uint256 => address) private _owners;

    // Mapping owner address to token count
    mapping(address => uint256) private _balances;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }
```
```python
pragma solidity ^0.8.0;

import "../ERC721.sol";

/**
 * @dev ERC721 token with storage based token URI management.
 */
abstract contract ERC721URIStorage is ERC721 {
    using Strings for uint256;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721URIStorage: URI query for nonexistent token");

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

```
```python
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
```
---

## Installation Guide

1. Open Gitbash or terminal and go in to the folder where you want to place the files.
2. Click on the green "code" button which will allow you to clone. ![Code button in Github](images/code.png)
3. Then click on SSH or HTTPS as a clone method depending on if you have the SSH key setup. You will copy the link. You will then type "git clone" in Gitback or Terminal. Then paste the ssh or https information and press enter. ![Clone in Github](images/clone.png)
4. Next type "git pull" command in Terminal or GitBash to pull the repository from the remote Github repository to a local directory on your computer. ![Git pull in Github](images/git_pull.png)
5. You have access to the project. Also there will be all the files that the application is depended on.  

---

## Usage

TMD NFT Minter Tutorial

This project contains the files for [Alchemy's NFT Minter tutorial](https://docs.alchemyapi.io/alchemy/tutorials/nft-minter). We have connected our Smart Contract to our React dApp project by building an NFT Minter using Metamask and Web3.

This React dApp is hosted on Heroku, [check it out](https://tmd-nft.herokuapp.com/)!

If you want to run it locally, please follow the next steps:

- Git clone this repository: `git clone https://github.com/jojomani/tm_disrupter.git`
- Go in to the follwoing directory _/tm_disrupter/nft-web-ui_ and run `npm install`
- After you have downloaded all the package dependencies, run `npm start`

You should see a tab open on your browser, running on *http://localhost:3000/* : 

![Local WebApp](readme_files/local_webapp.png)


## Contributors

This application is created for the purpose to completed a Project. The project is by Johann Maiga, Jonathan Bennett, Joshua James, Khatija Azeem, Scott Oziros and Nev Douglas. 

---

## License

For this application, we used Github to uplaod the file into a repository. Since this is a public file, there will be no restriction on usage of this code. 