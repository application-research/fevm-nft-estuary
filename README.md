# Estuary FEVM NFT Contract

The repository consists of ERC 721 Contracts

# Overview
We considered use cases of NFTs being owned and transacted by individuals as well as consignment to third party brokers/wallets/auctioneers (“operators”). NFTs can represent ownership over digital or physical assets. We considered a diverse universe of assets, and we know you will dream up many more:

- Physical property — houses, unique artwork
- Virtual collectables — unique pictures of kittens, collectable cards
- “Negative value” assets — loans, burdens and other responsibilities
- In general, all houses are distinct and no two kittens are alike. NFTs are distinguishable and you must track the ownership of each one separately.

The contracts here are based on EVM industry standard ERC721 protocol to create the Non-fungible tokens for a given digital asset. 

# Features
- ERC721, Enumerable, URI Storage for Digital Asset Look up and Royalties
- Set the minting price, and the developer funding address (every public mint token price goes to the dev account)
- Blind Box reveal using baseURI
- Estuary Gateway

# How to run the contract

## Method 1: Remix
- Open a blank workspace
- Load the files to local workspace

## Method 2: Truffle
Install the truffle library
```
npm install
```

Grab your network private key and put it on the truffle-config
```
open truffle-config.js
const privateKeys = ["<private key of deployer>"]; 
```

Run the following commands to deploy
```
truffle compile
truffle build
truffle deploy --network test // for testnet (mainnet for main network)
```

## Live contract
https://explorer.glif.io/tx/0x9a8c54a973c423335b0e7c3310960e7c373d526ba7d29ea17ddf4e5c41776807/?network=wallaby
