truffle用的是3.1.2，truffle serve启动后显示“Serving static assets in ./build on port 8080...”是正常，
由于truffle3.1.2版本build不好使用，我直接把页面和js放在build下面

## Conference

A simple Ethereum smart contract and lightwallet example.

For noobs! There might be bugs here.

### Updates

Current code uses *Truffle v3.1.2*


### Install

Install [testrpc] (or use geth)

```
$ npm install -g ethereumjs-testrpc
```

Install [truffle](https://github.com/consensys/truffle):

```
$ npm install -g truffle 
```

If you don't have solc you can get it [here](https://github.com/ethereum/go-ethereum/wiki/Contract-Tutorial#using-an-online-compiler)

### Run

Run testrpc in one console window:

```
$ testrpc
```
In another console window run truffle from project root directory:

```
$ truffle compile
$ truffle migrate
$ truffle test
$ truffle serve // server at localhost:8080
```


