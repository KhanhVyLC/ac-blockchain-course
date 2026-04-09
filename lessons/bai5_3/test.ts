import { ethers } from "ethers";

async function main() {
// Thay đổi dòng này
const provider = new ethers.JsonRpcProvider("https://sepolia.infura.io/v3/0e7cc5...");
  const abi = [
    "function getCount() public view returns (uint)",
    "function increment() public"
  ];
  const contractAddress = "0x6e7c59cdff95BD280B1501bf031D5aa418a31b7a"; // Replace with your contract address

  const contract = new ethers.Contract(contractAddress, abi, provider);

  const count = await contract.getCount();
  console.log("Current count is:", count.toString());
}

main().catch(console.error);
