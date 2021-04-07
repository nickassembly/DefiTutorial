pragma solidity ^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm {
    string public name = "Dapp Token farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    // Stakes Tokens (Deposit)
    function stakeTokens(uint _amount) public {
        // Require amount greater than 0
        require(_amount > 0, "amount cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        // Update staking balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        // Add user to stakers array *ONLY* if they haven't already staked
        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }
        
        // Update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;

    }
    
    // Unstake Tokens (Withdraw)

    // Issuing Tokens
    function issueToken() public {
        for (uint i=0; i < stakers.length; i++){
         address recipient = stakers[i];
         uint balance = stakingBalance[recipient];

         if(balance > 0){
            dappToken.transfer(recipient, balance);
         }
        
        }
    }


    

}

