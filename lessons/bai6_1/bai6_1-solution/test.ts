import { ethers } from "ethers";
import * as fs from "fs";
import * as path from "path";

async function main() {
  // Read deployer and infura id from .env file
  const envPath = path.join(__dirname, '.env');
  const envContent = fs.readFileSync(envPath, 'utf8');
  
  const deployerMatch = envContent.match(/DEPLOYER_ADDRESS=([^\r\n]+)/);
  const infuraMatch = envContent.match(/INFURA_PROJECT_ID=([^\r\n]+)/);
  
  const deployerAddress = deployerMatch ? deployerMatch[1].trim() : "YOUR_DEPLOYER_ADDRESS_HERE";
  const infuraId = infuraMatch ? infuraMatch[1].trim() : "your_infura_project_id_here";
  
  if (deployerAddress === "YOUR_DEPLOYER_ADDRESS_HERE" || infuraId === "your_infura_project_id_here") {
    console.log("Please set DEPLOYER_ADDRESS and INFURA_PROJECT_ID in .env file");
    return;
  }

  const provider = new ethers.JsonRpcProvider(`https://sepolia.infura.io/v3/${infuraId}`);

  const abi = [
    "function balanceOf(address) view returns (uint256)",
    "function decimals() view returns (uint8)"
  ];
  
  // Replace with your contract address after deployment
  const contractAddress = "0xC8BF7C199501cd9890CFCcBc923C2fA7D2a239B7";
  
  // No need to check since we have actual address

  const contract = new ethers.Contract(contractAddress, abi, provider);

  const balance = await contract.balanceOf(deployerAddress);
  const decimals = await contract.decimals();
  const formattedBalance = ethers.formatUnits(balance, decimals);
  
  console.log(`Balance of deployer (${deployerAddress}): ${formattedBalance} MTK`);
}

main().catch(console.error);
