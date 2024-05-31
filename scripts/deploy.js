const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  //Deploying Factory contract
  const Factory = await ethers.getContractFactory("Factory");
  await Factory.deploy();

  console.log("Factory contract is being deployed...");

  console.log("Factory deployed");


  //Deploying Token contract
  const Token = await ethers.getContractFactory("Token");

  const tokenName = "CATCOIN";
  const tokenSymbol = "CAT";
  const tokenDecimals = 18;
  const tokenTotalSupply = ethers.parseUnits("100", tokenDecimals);
  const ownerAddress = deployer.address;
  const factoryAddress = deployer.address;

  console.log(
    "Deploying with parameters:",
    tokenName,
    tokenSymbol,
    tokenDecimals,
    tokenTotalSupply.toString(),
    ownerAddress,
    factoryAddress
  );

  await Token.deploy(
    tokenName,
    tokenSymbol,
    tokenDecimals,
    tokenTotalSupply,
    ownerAddress,
    factoryAddress
  );

  console.log("Contract deployed");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
