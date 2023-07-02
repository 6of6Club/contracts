// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import { IERC721A } from "ERC721A/ERC721A.sol";
import { OnChain6of6Club } from "../src/OnChain6of6Club.sol";
import { TokenURI } from "../src/TokenURI.sol";

contract OnChain6of6ClubTest is Test {
    address _user1 = makeAddr("user1");
    address _user2 = makeAddr("user2");

    address[] _markets;
    address _market = makeAddr("market");

    OnChain6of6Club public token;
    TokenURI public uri;

    function setUp() public {
        token = new OnChain6of6Club();
        uri = new TokenURI(address(token));
        token.setTokenURI(address(uri));

        _markets.push(_market);
        (bool sent,) = _market.call{value: 100 ether}("");
        require(sent, "Failed to send Ether");
    }

    function testMintMax() public {
        token.mint(64);
        assertEq(token.totalSupply(), 64);
    }

    function testMintMaxError() public {
        vm.expectRevert("6of6.Club: Must mint between 1 and 64");
        token.mint(65);
    }

    function testOwner() public {
        hoax(_user1, 100 ether);

        token.mint(64);

        assertEq(token.ownerOf(11), _user1);

        vm.expectRevert(abi.encodeWithSelector(IERC721A.OwnerQueryForNonexistentToken.selector));
        assertEq(token.ownerOf(65), address(0));
    }

    function testSale() public {
        startHoax(_user1, 100 ether);

        token.mint(64);

        assertEq(token.ownerOf(11), _user1);
        assertEq(token.getApproved(11), address(0));

        token.transferFrom(_user1, _user2, 11);

        assertEq(token.ownerOf(11), _user2);

        vm.prank(address(this));
        uri.addMarket(_markets);

        startHoax(_user2, 100 ether);
        vm.prevrandao(bytes32(uint256(14)));
        token.transferFrom(_user2, _user1, 11);

        startHoax(_user1, 100 ether);
        vm.prevrandao(bytes32(uint256(14)));
        token.transferFrom(_user1, _user2, 11);

        startHoax(_user2, 100 ether);
        vm.prevrandao(bytes32(uint256(14)));
        token.transferFrom(_user2, _user1, 11);

        startHoax(_user1, 100 ether);
        vm.prevrandao(bytes32(uint256(14)));
        token.transferFrom(_user1, _user2, 11);

        startHoax(_user2, 100 ether);
        vm.prevrandao(bytes32(uint256(14)));
        token.transferFrom(_user2, _user1, 11);

        console.logString(token.tokenURI(11));

    }
}
