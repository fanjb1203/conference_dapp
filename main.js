var Web3 = require('web3');
var contract = require("truffle-contract");

var provider = new Web3.providers.HttpProvider("http://localhost:8545");

//使用truffle-contract包的contract()方法
//请务必使用你自己编译的.json文件内容
var Test = contract(
{
  "contract_name": "Test",
  "abi": [
    {
      "constant": false,
      "inputs": [],
      "name": "f",
      "outputs": [
        {
          "name": "",
          "type": "string"
        }
      ],
      "payable": false,
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [],
      "name": "g",
      "outputs": [
        {
          "name": "",
          "type": "string"
        }
      ],
      "payable": false,
      "type": "function"
    }
  ],
  "unlinked_binary": "0x606060405234610000575b6101ff806100196000396000f300606060405263ffffffff60e060020a60003504166326121ff0811461002f578063e2179b8e146100bc575b610000565b346100005761003c610149565b604080516020808252835181830152835191928392908301918501908083838215610082575b80518252602083111561008257601f199092019160209182019101610062565b505050905090810190601f1680156100ae5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b346100005761003c61018e565b604080516020808252835181830152835191928392908301918501908083838215610082575b80518252602083111561008257601f199092019160209182019101610062565b505050905090810190601f1680156100ae5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b604080516020818101835260009091528151808301909252600a82527f6d6574686f642066282900000000000000000000000000000000000000000000908201525b90565b604080516020818101835260009091528151808301909252600a82527f6d6574686f642067282900000000000000000000000000000000000000000000908201525b905600a165627a7a72305820cdb31af611a8c193a6954971e62bf13b9a49d7714c4abbcb38126f2943dc30290029",
  "networks": {
    "1489974124640": {
      "events": {},
      "links": {},
      "address": "0x6a7c26d50eff1063ca01ffc3b77b6474e62a838e",
      "updated_at": 1489974131011
    }
  },
  "schema_version": "0.0.5",
  "updated_at": 1489974131011
}
);

Test.setProvider(provider);

//没有默认地址，会报错
//UnhandledPromiseRejectionWarning: Unhandled promise rejection (rejection id: 3): Error: invalid address
//务必设置为自己的钱包地址，如果不知道，查看自己的客户端启动时，观察打印到控制台的地址
Test.defaults({
  from : "0x5c8ce99c01e109eb9863c1cff04c8a9ae318ca29"
});


var instance;
Test.deployed().then(function(contractInstance) {
  instance = contractInstance;
  return instance.f.call();
}).then(function(result){
  console.log("resulta="+result);
  return instance.g.call();
}).then(function(result){
  console.log("resultb="+result);
});
