// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";

import { IERC721A } from "ERC721A/ERC721A.sol";
import { OnChain6of6Club } from "../src/OnChain6of6Club.sol";
import { TokenURI } from "../src/TokenURI.sol";

/*
forge script script/Ethereum.s.sol:EthereumScript \
    --broadcast \
    --slow \
    --optimize \
    --optimizer-runs 9999999 \
    --verify \
    --verifier etherscan \
    -vvvv \
    --rpc-url "https://eth-mainnet.g.alchemy.com/v2/"
*/

contract EthereumScript is Script {
    uint256 _pk1 = vm.envUint("ETHEREUM_PRIVATE_KEY");

    address[] _markets;
    address _market = 0x00000000000000ADc04C56Bf30aC9d3c0aAF14dC;

    OnChain6of6Club public token;
    TokenURI public uri;

    function run() public {
        vm.startBroadcast(_pk1);

        token = new OnChain6of6Club();
        uri = new TokenURI(address(token));
        token.setTokenURI(address(uri));

        _markets.push(_market);
        uri.addMarket(_markets);

        vm.stopBroadcast();
    }
}