const hre = require("hardhat");

async function main() {
  const instancesE = await hre.ethers.getContractFactory("Ecommerce");
  const conDeployed = await instancesE.deploy();

  //   const conDeployed = await hre.ethers.deployContract("Ecommerce");

  const add = await conDeployed.getAddress();
  console.log(add);
}

main()
  .then(() => {
    console.log("successufuly Deployed");
  })
  .catch(() => {
    console.log("error to deploy");
  });

// npx hardhat run script/name
