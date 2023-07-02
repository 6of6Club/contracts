// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import { IERC721A } from "ERC721A/ERC721A.sol";
import { OnChain6of6Club } from "../src/OnChain6of6Club.sol";
import { TokenURI } from "../src/TokenURI.sol";
import { Multicall3 } from "../src/Multicall3.sol";

/*
forge script script/Anvil.s.sol:AnvilScript \
    --broadcast \
    --slow \
    --optimize \
    --optimizer-runs 9999999 \
    --rpc-url http://127.0.0.1:8545
*/

contract AnvilScript is Script {
    address _user1 = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address _user2 = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;

    uint256 _pk1 = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 _pk2 = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;

    address[] _markets;
    address _market = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    OnChain6of6Club public token;
    TokenURI public uri;

    function run() public {
        vm.startBroadcast(_pk1);

        uint256 tokens = 44;

        new Multicall3();

        token = new OnChain6of6Club();
        uri = new TokenURI(address(token));
        token.setTokenURI(address(uri));

        _markets.push(_market);
        uri.addMarket(_markets);

        token.mint(tokens);

        vm.stopBroadcast();
        vm.startBroadcast(_pk1);

        for (uint256 i; i < tokens; i++) {
            token.transferFrom(_user1, _user2, i);
        }

        vm.stopBroadcast();
        vm.startBroadcast(_pk2);

        for (uint256 i; i < tokens; i++) {
            token.transferFrom(_user2, _user1, i);
        }

        vm.stopBroadcast();
        vm.startBroadcast(_pk1);

        for (uint256 i; i < tokens; i++) {
            token.transferFrom(_user1, _user2, i);
        }

        vm.stopBroadcast();
        vm.startBroadcast(_pk2);

        for (uint256 i; i < tokens; i++) {
            token.transferFrom(_user2, _user1, i);
        }

        vm.stopBroadcast();
        vm.startBroadcast(_pk1);

        for (uint256 i; i < tokens; i++) {
            token.transferFrom(_user1, _user2, i);
        }

        vm.stopBroadcast();
    }
}