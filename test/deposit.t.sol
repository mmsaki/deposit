// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;

pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {stdJson} from "forge-std/StdJson.sol";
import {DepositContract} from "../src/deposit.sol";
import {DepositSetup} from "./depositSetup.t.sol";

contract DepositTest is DepositSetup {
    function setUp() public virtual override {
        super.setUp();
        vm.deal(address(this), 32 ether);
    }

    function test_Deposit32ETH() public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = get_32ETH_deposit_params();

        // 2. Call deposit
        deposit.deposit{value: 32 ether}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );
    }

    function testFuzz_Deposit_Bad_Signature(bytes32 a, bytes32 b, bytes32 c) public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = get_32ETH_deposit_params();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: reconstructed DepositData does not match supplied deposit_data_root"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            depositData.withdrawal_credentials,
            // bad signature
            abi.encodePacked(a, b, c),
            depositData.deposit_data_root
        );
    }

    function testFuzz_Deposit_Bad_Withdraw_Address(uint8 marker, address withdraw) public payable {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = get_32ETH_deposit_params();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: reconstructed DepositData does not match supplied deposit_data_root"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            // bad withdrawal address
            abi.encodePacked(uint256(marker << 0xf8) | uint256(withdraw)),
            depositData.signature,
            depositData.deposit_data_root
        );
    }

    function testDeposit_31ETH_Then_1ETH() public {
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
