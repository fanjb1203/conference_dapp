pragma solidity ^0.4.4;

contract Decode{
    //验证数据入口函数
    function decode() returns(address){
        bytes memory sigedString=hex"6e23c2bf8b734b3bbd319899b1d7b209bacc781d777a1c3916c22ecab6e70483262ee8d51c337bef7b06123bf76f08882fe7e37334fdfee69f8c9419d1f428b101";
        bytes32 r = bytesToByes32(slice(sigedString,0,32));
        bytes32 s = bytesToByes32(slice(sigedString,32,32));
        byte v = slice(sigedString,64,1)[0];
        return ecrecoverDecode(r,s,v);
    }
    function slice(bytes memory data,uint start,uint len) returns(bytes){
        bytes memory b = new bytes(len);
        for(uint i=0;i<len;i++){
            b[i] = data[i+start];
        }
        return b;
    }
    //使用ecrecover恢复公钥
    function ecrecoverDecode(bytes32 r,bytes32 s,byte v1) returns(address addr){
        uint8 v = uint8(v1)+27;
        addr = ecrecover(hex"4e03657aea45a94fc7d47ba826c8d667c0d1e6e33a64a036ec44f58fa12d6c45",v,r,s);
    }
    //byte转换为bytes32
    function bytesToByes32(bytes memory source) returns(bytes32 result){
        assembly{
            result := mload(add(source,32))
        }
    }
}

