//module.exports = function(deployer) {
//  deployer.deploy(Conference);
  //deployer.autolink(); // for linking imports of other contracts
//};

var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var Greeter = artifacts.require("./Greeter.sol");
var Ballot = artifacts.require("./Ballot.sol");
var Conference = artifacts.require("./Conference.sol");
var Test = artifacts.require("./Test.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(MetaCoin);
  deployer.deploy(Greeter);
  deployer.deploy(Ballot);
  deployer.deploy(Conference);
  deployer.deploy(Test);
};
