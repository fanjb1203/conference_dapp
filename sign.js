var Web3 = require('web3');
var web3 = new Web3();
var provider = new web3.providers.HttpProvider('http://192.168.9.147:8545'); //根据自己的ip修改
web3.setProvider(new web3.providers.HttpProvider('http://192.168.9.147:8545'));

var account = web3.eth.accounts[0];
var sha3Msg = web3.sha3("abc");
var signedData = web3.eth.sign(account,sha3Msg);

console.log("account="+account);
console.log("sha3Msg="+sha3Msg);
console.log("signedData="+signedData);