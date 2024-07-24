const hre = require("hardhat");

async function main() {
  const signerAddress = "";

  // Get the signer from the address
  const signer = await hre.ethers.getSigner(signerAddress);

  console.log("Deploying contracts with the account:", signer.address);

  // Get the contract factory
  const NFTFactory = await hre.ethers.getContractFactory("NftFactory");

  // Deploy the contract (assuming no additional constructor arguments)
  const nftFactory = await NFTFactory.deploy();

  // Wait for the deployment to be mined
  await nftFactory.waitForDeployment();

  console.log(
    "NFT contract deployed at address:",
    await nftFactory.getAddress()
  );
}

// Execute the deployment function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
