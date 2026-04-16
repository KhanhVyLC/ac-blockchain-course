const { ethers, deployments, getNamedAccounts } = require("hardhat");

module.exports = async function () {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log("Deploying MyNFT contract with the account:", deployer);

  const myNFT = await deploy("MyNFT", {
    from: deployer,
    args: [],
    log: true,
  });

  console.log("MyNFT deployed to:", myNFT.address);

  if (myNFT.newlyDeployed) {
    console.log("Minting NFT to deployer...");
    const MyNFT = await ethers.getContractAt("MyNFT", myNFT.address, deployer);
    await MyNFT.mint(deployer);

    console.log("NFT minted successfully!");
    console.log("Owner of token 0:", await MyNFT.ownerOf(0));
  }
};

module.exports.tags = ["deploy", "nft"];