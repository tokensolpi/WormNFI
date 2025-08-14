const { ethers } = require("ethers");

async function main() {
  // Connect to the local blockchain provider (e.g., Hardhat Network, Ganache)
  const provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");

  // Get the signer (the account that will deploy the contract)
  const signer = await provider.getSigner();
  console.log("Deploying contract with the account:", await signer.getAddress());

  // Get the contract factory for the WormholeEnabledToken
  const Token = await ethers.getContractFactory("WormholeEnabledToken", signer);

  // Deploy the contract with constructor arguments
  const token = await Token.deploy("Worm Rodeo Token", "WRT");

  // Wait for the contract to be deployed
  await token.waitForDeployment();

  console.log("WormholeEnabledToken deployed to:", await token.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });