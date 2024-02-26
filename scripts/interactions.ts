import {ethers} from 'hardhat';

async function main() {
    const contractAddress = "0x3b48480DF6F5E79b395a1a03578f2e8aEcBeD99d";
    const DefiInsurance = await ethers.getContractAt("DefiInsurance", contractAddress);
}



// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });