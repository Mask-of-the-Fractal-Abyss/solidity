pragma solidity ^0.5.1;

contract dao{
  address payable addr = address(uint160(address(this)));
  address[] public rules;

  struct prop {
    proposal p;
    address o;
  }

  function reroute(address old, address new_) public{
    if (old == address(0)){
      rules.push(new_);
      return;
    }
    for(uint i = 0; i < rules.length; i++){
      if (rules[i] == old) {
        rules[i] = new_;
        return;
      }
    }
  }

  function propose(address old, address new_) payable public{
    new proposal(old, new_);
  }
}

contract proposal{
  address old;
  address new_;
  int forVotes;
  int againstVotes;
  address payable owner;
  constructor(address _old, address _new_) public{
    old = _old;
    new_ = _new_;
    forVotes = 0;
    againstVotes = 1;
    owner = msg.sender;
  }

  function vote(bool forAgainst) payable public{
    require(msg.value >= 8);
    owner.transfer(msg.value);
    if (forAgainst) forVotes += 1;
    else againstVotes += 1;
  }

  function verdict() payable public{
    require(msg.value >= 8);
    owner.transfer(msg.value);
    if (forVotes > againstVotes){
      dao(owner).reroute(old, new_);
      selfdestruct(address(uint160(address(this))));
    }
  }
}

contract timedEvent{
  uint reward;
  uint time;
  address payable addr = address(uint160(address(this)));
  constructor(uint r, uint t) payable public{
    require(r == msg.value);
    addr.transfer(msg.value);
    reward = r;
    time = t;
  }

  function claim() public{
    require(now >= time);
    msg.sender.transfer(reward);
  }
}