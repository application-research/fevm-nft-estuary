

const Estuary721 = artifacts.require("Estuary721")

module.exports = function (deployer) {
  deployer.deploy(Estuary721,"Estuary","EST",10000); // create Estuary Token with 10000 limit
};