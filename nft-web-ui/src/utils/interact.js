// import { load } from 'dotenv';
import { pinJSONToIPFS } from './pinata.js'
require('dotenv').config();
const alchemyKey = process.env.REACT_APP_ALCHEMY_KEY;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3("https://eth-rinkeby.alchemyapi.io/v2/" + alchemyKey);
// const web3 = createAlchemyWeb3(alchemyKey);

const contractABI = require('../contract-abi2.json')

// 1st Contract 
// const contractAddress = "0xdE4F610bDFBd0075c2A4871f56E3421A999aBB01";

// 2nd Contract - Updated new version
const contractAddress = "0xF34125cA072942d30A633f83aF56f935109696b7";


export const connectWallet = async () => {
    if (window.ethereum) {
      try {
        const addressArray = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        const obj = {
          status: "👆🏽 Write a message in the text-field above.",
          address: addressArray[0],
        };
        return obj;
      } catch (err) {
        return {
          address: "",
          status: "😥 " + err.message,
        };
      }
    } else {
      return {
        address: "",
        status: (
          <span>
            <p>
              {" "}
              🦊{" "}
              <a target="_blank" href={`https://metamask.io/download.html`}>
                You must install Metamask, a virtual Ethereum wallet, in your
                browser.
              </a>
            </p>
          </span>
        ),
      };
    }
  };

  export const getCurrentWalletConnected = async () => {
    if (window.ethereum) {
      try {
        const addressArray = await window.ethereum.request({
          method: "eth_accounts",
        });
        if (addressArray.length > 0) {
          return {
            address: addressArray[0],
            status: "👆🏽 Write a message in the text-field above.",
          };
        } else {
          return {
            address: "",
            status: "🦊 Connect to Metamask using the top right button.",
          };
        }
      } catch (err) {
        return {
          address: "",
          status: "😥 " + err.message,
        };
      }
    } else {
      return {
        address: "",
        status: (
          <span>
            <p>
              {" "}
              🦊{" "}
              <a target="_blank" href={`https://metamask.io/download.html`}>
                You must install Metamask, a virtual Ethereum wallet, in your
                browser.
              </a>
            </p>
          </span>
        ),
      };
    }
  };

  async function loadContract() {
    return new web3.eth.Contract(contractABI, contractAddress);
  }

export const mintNFT = async (url, name, description) => {
  if (url.trim() == "" || (name.trim() == "" || description.trim() == "")) {
    return {
      success: false,
      status: "❗Please make sure all fields are completed before minting.",
    }
  }
  //make metadata
  const metadata = new Object();
  metadata.name = name;
  metadata.image = url;
  metadata.description = description;

  //make pinata call
  const pinataResponse = await pinJSONToIPFS(metadata);
  if (!pinataResponse.success) {
    return {
      success: false,
      status: "😢 Something went wrong while uploading your tokenURI.",
    };
  }
  const tokenURI = pinataResponse.pinataUrl;
    
  //load smart contract
window.contract = await new web3.eth.Contract(contractABI, contractAddress);
  console.log(window.contract)

  //set up your Ethereum transaction
  const transactionParameters = {
    to: contractAddress, // Required except during contract publications.
    from: window.ethereum.selectedAddress,
    // 'nonce': web3.eth.Contract.getTransactionCount('latest'),
    'gas': "80000",
    'maxFeePerGas': "52079999" ,
    'maxPriorityFeePerGas': "51999999", // must match user's active address.
    'data': window.contract.methods
      .mintNFT(window.ethereum.selectedAddress, tokenURI)
      .encodeABI()//make call to NFT smart contract 
  };

  // const signedTx = await web3.eth.accounts.signTransaction(transactionParameters, alchemyKey);
  // const transactionReceipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
  // console.log(`Transaction receipt: ${JSON.stringify(transactionReceipt)}`);


  console.log(transactionParameters)
  //sign the transaction via Metamask
  if (window.ethereum) {
    try {
      const txHash = await window.ethereum.request({
        method: 'eth_sendTransaction',
        params: [transactionParameters],
      });
      console.log("made it")
      return {
        success: true,
        status: "✅ Check out your transaction on Etherscan: https://rinkeby.etherscan.io/tx/" + txHash
      };
    } catch (error) {
      return {
        success: false,
        status: "😥 Something went wrong: " + error.message
      };
    }
  }
};

// try {
//   const txHash =  window.ethereum.request({
//     method: 'eth_sendTransaction',
//     params: [transactionParameters],
//   });
//   console.log("made it")
//   return {
//     success: true,
//     status: "✅ Check out your transaction on Etherscan: https://rinkeby.etherscan.io/tx/" + txHash
//   };
// } catch (error) {
//   return {
//     success: false,
//     status: "😥 Something went wrong: " + error.message
//   };
// }