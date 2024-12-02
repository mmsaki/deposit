// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;

pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {DepositContract} from "../src/deposit.sol";

contract DepositTest is Test {
    DepositContract public deposit;

    function setUp() public {
        deposit = new DepositContract();
        vm.deal(address(this), 32 ether);
    }

    function testFuzz_Deposit32ETH_Once(

        ) public payable {
        bytes memory p = hex"92fbe9f4761625673fe21ce9db5c975d40f1f64e1b554ebb5bd71d0a5de13d30d8ed894cceb5487d193b9defb23eb941";
        bytes memory w = hex"010000000000000000000000fe948cb2122fdd87baf43dce8afa254b1242c199";
        bytes memory s = abi.encodePacked(
            bytes32(0x86d64339aca21ba35a7762fd8e40b8b56618f61546455efe2a6073954eff1884),
            bytes32(0x7e927fce031bd90fb77bfa88b46966ac0c20217ab40846bea8120306102b6b26),
            bytes32(0x108efe39acf5ead479e21f8686c120510b83ef83e7b1c43cf2ecaeca69fb6f56)
            );
        bytes32 d = 0x08345126fa802d58b2afb567bee5879c9d19dd228f099f5b271944bb64f1bacd;

        console.log(block.timestamp, "0.0 Contract balance:", address(this).balance / 1 ether, "ETH");
        deposit.deposit{value: 32 ether}(p,w,s,d);

        console.log(block.timestamp, "0.1 Depositing", 32 ether, "wei...");
        console.log(block.timestamp, "0.2 Contract balance:", address(this).balance, "ETH");
        console.log("0.3 Exit. ⚠️");
    }

    function testFuzz_Deposit_31ETH_Then_1ETH(
        ) public payable {
        /* TODO: 
        * Write function where
        * 1. You deposit 31 Eth to DepositContract, then
        * 2. You deposit 1 Eth to DepositContract
        */

        // begin
    }

    function test_Get_Deposit_Count() public {
        /* TODO: 
        * Write function where
        * 1. You deposit 32 Eth to DepositContract, then
        * 2. You get deposit count
        */

        // begin
    }

    function test_Get_Deposit_Root() public {
        /* TODO: 
        * Write function where
        * 1. You deposit 32 Eth to DepositContract, then
        * 2. You get deposit root
        */

        // begin
    }
}

