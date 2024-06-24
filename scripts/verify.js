const hre = require("hardhat");

async function main() {
  await hre.run("verify:verify", {
    //Deployed contract address
    address: "0x45F494801996556a38937A164E0bE97AEe02e811",
    //Pass arguments as string and comma seprated values
    constructorArguments: [],
    //Path of your main contract.
    contract: "contracts/facets/Store.sol:Store",
  });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

/**
 * 
 * DiamondCutFacet deployed: 0x1532A94EcF1dcf25844dCcE78D922471E249A6e7
Diamond deployed: 0xd3b108bf03cc47635C5F114c274d492514EB3aA5
DiamondInit deployed: 0x56dD8574A0bce21DfA8D46AB988C2c3a45AF6441

Deploying facets
DiamondLoupeFacet deployed: 0x5BB138e7DEa4B326778cf5AC3D4205A913F5e761
OwnershipFacet deployed: 0xb6F3A94221CFB78cd3a4dC20955c23279893Bc2E
Store deployed: 0x45F494801996556a38937A164E0bE97AEe02e811

Diamond cut tx:  0x395b0e6e95688a0a81cfa38c1ffebfbf4ff365976320ba2f8f1f413218537edb

Diamond Cut: [
  {
    facetAddress: '0x5BB138e7DEa4B326778cf5AC3D4205A913F5e761',
    action: 0,
    functionSelectors: [
      '0xcdffacc6',
      '0x52ef6b2c',
      '0xadfca15e',
      '0x7a0ed627',
      '0x01ffc9a7',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  },
  {
    facetAddress: '0xb6F3A94221CFB78cd3a4dC20955c23279893Bc2E',
    action: 0,
    functionSelectors: [
      '0x8da5cb5b',
      '0xf2fde38b',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  },
  {
    facetAddress: '0x45F494801996556a38937A164E0bE97AEe02e811',
    action: 0,
    functionSelectors: [
      '0x70480275',
      '0x8ada066e',
      '0x1785f53c',
      '0x83b8a5ae',
      '0x8bb5d9c3',
      '0xada8f919',
      contract: [Contract],
      remove: [Function: remove],
      get: [Function: get]
    ]
  }
]
 */