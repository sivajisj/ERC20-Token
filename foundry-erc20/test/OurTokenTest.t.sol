// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol"; 
import {OurToken} from "../src/OurToken.sol"; 

contract ourTokenTest is Test {

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;
    
    OurToken public ourToken ;
    DeployOurToken public deployer ;

    function setUp()public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob,STARTING_BALANCE);
    }

    function testBobBalance()public {
        assertEq(STARTING_BALANCE,ourToken.balanceOf(bob));
        
    }
}