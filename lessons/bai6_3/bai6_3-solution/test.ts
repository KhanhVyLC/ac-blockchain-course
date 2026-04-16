import { ethers } from "ethers";

async function main() {
  const provider = new ethers.JsonRpcProvider(`https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`);
  
  // ABI for MyNFT contract
  const abi = [
    "function mint(address to)",
    "function ownerOf(uint256 tokenId) view returns (address)"
  ];
  
  // Replace with your deployed contract address
  const contractAddress = "0x68FC9e514A0d3af48346D74d346169A5e58Ad636";
  
  // Create wallet with private key
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, provider);
  const contract = new ethers.Contract(contractAddress, abi, wallet);

  // Mint NFT to deployer
  console.log("Minting NFT...");
  const tx = await contract.mint(wallet.address);
  await tx.wait();
  
  console.log("NFT minted successfully!");
  
  // Check owner of token 0
  const owner = await contract.ownerOf(0);
  console.log("Owner of token 0:", owner);
}

main().catch(console.error);
