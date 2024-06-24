
/* global ethers task */
require('@nomiclabs/hardhat-waffle')
require('@nomicfoundation/hardhat-verify')
// const { vars } = require("hardhat/config");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task('accounts', 'Prints the list of accounts', async () => {
  const accounts = await ethers.getSigners()

  for (const account of accounts) {
    console.log(account.address)
  }
})

const APIKey = ``;

// const SEPOLIA_PRIVATE_KEY = vars.get("95585dbc649088cbaedff1311270df683fbe8a8b34f439cb8a8279880ab339a7");
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: '0.8.16',
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    bscTestnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [],
    },
  },
  etherscan: {
    apiKey: APIKey,
  },
}
