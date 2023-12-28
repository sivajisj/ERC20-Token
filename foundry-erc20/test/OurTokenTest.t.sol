// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol"; 
import {OurToken} from "../src/OurToken.sol"; 

contract ourTokenTest is Test {

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant BOB_STARTING_AMOUNT  = 100 ether;
    
    OurToken public ourToken ;
    DeployOurToken public deployer ;

    function setUp()public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob,BOB_STARTING_AMOUNT );
    }

    function testBobBalance()public {
        assertEq(BOB_STARTING_AMOUNT ,ourToken.balanceOf(bob));
        
    }

     function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }

}