pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {

    constructor(
        uint rate,
        address payable wallet,
        kaseiCoin token
    ) 
        Crowdsale(rate, wallet, token)
        public
    {
        // constructor can stay empty
    }
}


contract KaseiCoinCrowdsaleDeployer {

    // Create an `address public` variable called `kasei_token_address`.
    address public kasei_token_address;
    
    // Create an `address public` variable called `kasei_crowdsale_address`.
    address public kasei_crowdsale_address;

    // Add the constructor.
    constructor(
       string memory name,
       string memory symbol,
       address payable wallet
    ) 
       public 
       
    {

        // Create a new instance of the KaseiCoin contract.
        KaseiCoin token = new kaseiCoin(name, symbol, 0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale kaseicoin_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);

        // Assign the `KaseiCoinCrowdsale` contract’s address to the; `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(kaseicoin_crowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}