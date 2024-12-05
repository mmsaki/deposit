// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;

pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {stdJson} from "forge-std/StdJson.sol";
import {DepositContract} from "../src/deposit.sol";
import {DepositSetup} from "./depositSetup.t.sol";

contract DepositTest is DepositSetup {
    DepositContract mainnetDeposit;
    DepositContract holeskyDeposit;

    function setUp() public virtual override {
        super.setUp();
        vm.deal(address(this), 32 ether);

        mainnetDeposit = DepositContract(0x00000000219ab540356cBB839Cbe05303d7705Fa);
        holeskyDeposit = DepositContract(0x4242424242424242424242424242424242424242);
    }

    function test_ValidDeposit_Success() public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        deposit.deposit{value: 32 ether}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );
    }

    function test_SuccessFullDeposit() public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        vm.createSelectFork("holesky");
        holeskyDeposit.deposit{value: 32 ether}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );
    }

    /*
    * BUG: User can create generate malicious deposit data because contract does not verify.
    */
    function test_FailFakeDeposit(bytes32 p, uint64 amount, bytes32 a, bytes32 b, bytes32 c) public {
        amount = uint64(bound(amount, 1 ether, uint256(2 ** 64 - 1))) / 1 gwei * 1 gwei;

        // 1. Get valid Fake deposit params
        DepositSetup.DepositData memory depositData =
            _generateFakeParams(p, bytes32(uint256(address(this))), amount, a, b, c);

        // 2. Call deposit
        deposit.deposit{value: amount}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );
    }

    /*
    * BUG: Allows deposit data to be reused on different chain?
    *      Allows deposit data to be used on the same chain.
    */
    function test_FailReusedDepositParams() public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit on mainnet
        vm.createSelectFork("mainnet");
        mainnetDeposit.deposit{value: 32 ether}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );

        // 3. Call deposit on holesky
        vm.createSelectFork("holesky");
        vm.deal(address(this), 32 ether);
        holeskyDeposit.deposit{value: 32 ether}(
            depositData.pubkey, depositData.withdrawal_credentials, depositData.signature, depositData.deposit_data_root
        );
    }

    function test_InvalidSignature_Fail(bytes32 a, bytes32 b, bytes32 c) public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: reconstructed DepositData does not match supplied deposit_data_root"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            depositData.withdrawal_credentials,
            // BAD SIGNATURE: deposit data root != hash(hash(hash(pubkey, bytes16(0)), withdrawal_credentials), sha256(bytes8(amount), bytes24(0), hash(signature))))
            abi.encodePacked(a, b, c),
            depositData.deposit_data_root
        );
    }

    function test_InvalidSignatureLength_Fail(bytes32 a, bytes32 b) public {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: invalid signature length"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            depositData.withdrawal_credentials,
            // bad signature length
            abi.encodePacked(a, b),
            depositData.deposit_data_root
        );
    }

    function test_InvalidWithdraw_Fail(uint8 marker, address withdraw) public payable {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: reconstructed DepositData does not match supplied deposit_data_root"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            // bad random withdrawal address
            abi.encodePacked(uint256(marker << 0xf8) | uint256(withdraw)),
            depositData.signature,
            depositData.deposit_data_root
        );
    }

    function test_InvalidWithdrawLength_Fail(address withdraw) public payable {
        // 1. Get valid BLS params
        DepositSetup.DepositData memory depositData = _getHoleskyFullDepositParams();

        // 2. Call deposit
        vm.expectRevert(bytes("DepositContract: invalid withdrawal_credentials length"));
        deposit.deposit{value: 32 ether}(
            depositData.pubkey,
            // bad withdrawal_credentials length
            abi.encodePacked(uint160(withdraw)),
            depositData.signature,
            depositData.deposit_data_root
        );
    }

    function test_ValidPartialDeposit_Success() public {
        /* TODO: 
        * Write function where
        * 1. You deposit 31 Eth to DepositContract, then
        * 2. You deposit 1 Eth to DepositContract
        */

        // 0. Get partial deposits
        DepositSetup.DepositData[] memory depositData = _getHoleskyPartialDepositParams();

        // 1. Call with 31 ETH data
        deposit.deposit{value: 31 ether}(
            depositData[0].pubkey,
            depositData[0].withdrawal_credentials,
            depositData[0].signature,
            depositData[0].deposit_data_root
        );

        // 2. Call with 1 ETH data
        deposit.deposit{value: 1 ether}(
            depositData[1].pubkey,
            depositData[1].withdrawal_credentials,
            depositData[1].signature,
            depositData[1].deposit_data_root
        );
    }

    function test_ValidDepositCount_Success() public {
        /* TODO: 
        * Write function where
        * 1. You deposit 32 Eth to DepositContract, then
        * 2. You get deposit count
        */

        // begin
    }

    function test_ValidDepositRoot_Success() public {
        /* TODO: 
        * Write function where
        * 1. You deposit 32 Eth to DepositContract, then
        * 2. You get deposit root
        */

        // begin
    }
}
