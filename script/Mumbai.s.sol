// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import { IERC721A } from "ERC721A/ERC721A.sol";
import { OnChain6of6Club } from "../src/OnChain6of6Club.sol";
import { TokenURI } from "../src/TokenURI.sol";

/*
forge script script/Mumbai.s.sol:MumbaiScript \
    --broadcast \
    --slow \
    --optimize \
    --optimizer-runs 9999999 \
    -vvvv \
    --rpc-url "https://polygon-mumbai.g.alchemy.com/v2/"
*/

contract MumbaiScript is Script {
    address _user1 = vm.envAddress("USER_1");
    address _user2 = vm.envAddress("USER_2");

    uint256 _pk1 = vm.envUint("PRIVATE_KEY_1");
    uint256 _pk2 = vm.envUint("PRIVATE_KEY_2");

    address[] _markets;
    address _market = 0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC;

    OnChain6of6Club public token;
    TokenURI public uri;

    function run() public {
        vm.startBroadcast(_pk1);

        token = new OnChain6of6Club();
        uri = new TokenURI(address(token));
        token.setTokenURI(address(uri));

        // uint256 tokens = 3;

        // _markets.push(_user1);
        // uri.addMarket(_markets);

        // token.mint(tokens);
        // token.mint(2);

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk1);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user1, _user2, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk2);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user2, _user1, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk1);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user1, _user2, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk2);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user2, _user1, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk1);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user1, _user2, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk2);

        // for (uint256 i; i < tokens; i++) {
        //     token.transferFrom(_user2, _user1, i);
        // }

        // vm.stopBroadcast();
        // vm.startBroadcast(_pk1);

        // uri.delMarket(_markets);
        // delete _markets[0];
        _markets.push(_market);
        uri.addMarket(_markets);

        vm.stopBroadcast();
    }
}