

const Estuary721 = artifacts.require("Estuary721")
const Estuary1155 = artifacts.require("Estuary1155")
//const DieselPriceOracleCall = artifacts.require("DieselPriceOracleCall")
module.exports = function (deployer) {
  deployer.deploy(Estuary721,"Estuary","EST",10000); // create Estuary Token with 10000 limit
  deployer.deploy(Estuary1155); // create Estuary Token with 10000 limit
  //deployer.deploy(DieselPriceOracleCall); 
};