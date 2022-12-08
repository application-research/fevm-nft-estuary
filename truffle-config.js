//const HDWalletProvider = require("truffle-hdwallet-provider-privkey");
const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKeys = ["<>"]; 

module.exports = {

  plugins: [
    'truffle-plugin-verify'
  ],

   networks: { // if you have ganache
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard Ganache Port (default: none)
      network_id: "*",       // Any network (default: none)
    },
    testnet: {
      provider: () => new HDWalletProvider(privateKeys, `https://wallaby.node.glif.io/rpc/v0`),
      network_id: 18,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    mainnet: {
      provider: () => new HDWalletProvider(privateKeys, `https://wallaby.node.glif.io/rpc/v0`),
      network_id: 18,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },
  

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.7",    // Fetch exact version from solc-bin (default: truffle's version)
      }
    },
};
