pragma solidity ^0.4.0;

contract overseer {
    mapping(address => uint128) vc;
    address[] vclst;
    address su;

    // Venture Capitalist, Start up
    function overseer(address vc_, address su_) public{
        require(msg.value > 0);
        vc[vc_] = msg.value;
        vslst.push(vc);
        su = su_;
    }

    // Any new contributors
    function deposit(){
        require(msg.value > 0);
        vc[vc_] = msg.value;
        for (int i = 0; i < vclst.length; i++) {
            address addr = vclst[i];
            addr.transfer(msg.value / vc[addr]);
        }
    }
    
    function transact(uint256 amt, address dest){
        if (msg.sender == su) dest.transfer(amt);
    }
}
