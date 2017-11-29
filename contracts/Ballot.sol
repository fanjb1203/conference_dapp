pragma solidity ^0.4.4;

contract Ballot {
   //一个选民的构造体
    struct Voter {
        uint weight; // 权重（即他可以投几票）
        bool voted;  //是否已经投过票
        address delegate; // 代表地址（他可以代表某个人进行投票）
        uint vote;   // 当前投票的索引
    }

    // 投票的提案的构造体
    struct Proposal
    {
        bytes32 name;   // 提案名称
        uint voteCount; //获得的票数
    }

    address public chairperson;//会议主席

    //地址 -选民 的map
    mapping(address => Voter) public voters;

    // 投票种类的动态数组
    Proposal[] public proposals;

    ///构造函数
    function Ballot(bytes32[] proposalNames) {
        chairperson = msg.sender;//初始化会议主席
        voters[chairperson].weight = 1;

       //初始化所有的提案
        for (uint i = 0; i < proposalNames.length; i++) {

            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    // 给予投票权
    function giveRightToVote(address voter) returns (bool b) {
        if (msg.sender != chairperson || voters[voter].voted) {
            //对于会议主席和已经投过票的选民这里不处理
            return false;
        }
        voters[voter].weight = 1;
        return true;
    }

    /// 投票权转移函数
    function delegate(address to) {
        // 投票权转移的发起人
        Voter sender = voters[msg.sender];
        if (sender.voted)
            throw;

      //递归找到没有转移投票权的  选民
        while (
            voters[to].delegate != address(0) &&
            voters[to].delegate != msg.sender
        ) {
            to = voters[to].delegate;
        }


        if (to == msg.sender) {
            throw;
        }


       //将发起人设置为已经投过票的状态
        sender.voted = true;
        //将代表设置为刚才递归获取的选民
        sender.delegate = to;
        Voter delegate = voters[to];
        if (delegate.voted) {
            //如果代表已经投过票就在他投票的提案的票数增加
            proposals[delegate.vote].voteCount += sender.weight;
        }
        else {
           //将代表的的票数增加
            delegate.weight += sender.weight;
        }
    }

    /// 投票函数
    function vote(uint proposal) {
        Voter sender = voters[msg.sender];
        if (sender.voted)
            throw;
        sender.voted = true;
        sender.vote = proposal;

        //将投的提案票数增加
        proposals[proposal].voteCount += sender.weight;
    }

    ///获得票数最多的提案
    function winningProposal() constant returns (uint winningProposal) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal = p;
            }
        }
    }
}
