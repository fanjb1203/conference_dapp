pragma solidity ^0.4.4;

contract Conference {
  address public organizer; //会议组织者的钱包地址 一般处理成第一个账号
  mapping (address => uint) public registrantsPaid ;
  uint public numRegistrants;
  uint public quota;

  event Deposit(address _from, uint _amount);  // 充值 so you can log these events
  event Refund(address _to, uint _amount); 

  function Conference() { // Constructor
    organizer = msg.sender;
    quota = 500;
    numRegistrants = 0;
  }
  //买票
  function buyTicket() public payable returns(bool success) {
    if (numRegistrants >= quota) { return false; }
    registrantsPaid[msg.sender] = msg.value;
    numRegistrants++;
    Deposit(msg.sender, msg.value); //事件(Event)把交易记录进日志
    return true;
  }
  function changeQuota(uint newquota) public {
    if (msg.sender != organizer) { return; }
    quota = newquota;
  }
  function refundTicket(address recipient, uint amount) public {
    if (msg.sender != organizer) { return; }
    if (registrantsPaid[recipient] == amount) { 
      address myAddress = this;//使用this来访问这个合约地址
      if (myAddress.balance >= amount) { 
        //把资金发回了购票人
        if(!recipient.send(amount)){throw;}
        registrantsPaid[recipient] = 0;
        numRegistrants--;
        Refund(recipient, amount);//事件(Event)把交易记录进日志
      }
    }
  }
  function destroy() { // so funds not locked in contract forever
    if (msg.sender == organizer) { 
      //资金通过suicide函数被释放给了构造函数中设置的组织者地址,没有这个，资金可能被永远锁定在合约之中
      suicide(organizer); // send funds to organizer  
    }
  }
}