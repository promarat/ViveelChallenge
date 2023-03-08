// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const CTOAddress = 0xABCDEF1234567890ABCDEF1234567890ABCDEF12;
  const CEOAddress = 0xFEDCBA9876543210FEDCBA9876543210FEDCBA98;
  const confirmation = 2;

  const MultiSig = await hre.ethers.getContractFactory("MultiSigWallet");
  const multiSig = await MultiSig.deploy([CTOAddress, CEOAddress], confirmation);

  await multiSig.deployed();

  console.log(
    `New Multi Sign Wallet is deployed to ${multiSig.address}`
  );

  const MyToken = await hre.ethers.getContractFactory("MyERC20Token");
  const myToken = await MyToken.deploy(multiSig.address);

  await myToken.deployed();

  console.log(
    `MyERC20Token is deployed to ${myToken.address}`
  )
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
