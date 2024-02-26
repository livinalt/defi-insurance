import { ethers } from "hardhat";

async function main() {
  
  const defiInsurance = await ethers.deployContract("DefiInsurance");

  await defiInsurance.waitForDeployment();

  console.log(
    `DefiInsurance contract has been deployed to ${defiInsurance.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
