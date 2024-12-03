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

    // function testMerkleRootMatchesJSImplementationFuzzed(bytes32[] memory leaves) public {
    //     vm.assume(leaves.length > 1);
    //     bytes memory packed = abi.encodePacked(leaves);
    //     string[] memory runJsInputs = new string[](8);
    //     // Build ffi command string
    //     runJsInputs[0] = 'deposit';
    //     runJsInputs[1] = '--prefix';
    //     runJsInputs[2] = 'differential_testing/scripts/';
    //     runJsInputs[3] = '--silent';
    //     runJsInputs[4] = 'run';
    //     runJsInputs[5] = 'generate-root-cli';
    //     runJsInputs[6] = leaves.length.toString();
    //     runJsInputs[7] = packed.toHexString();

    //     // Run command and capture output
    //     bytes memory jsResult = vm.ffi(runJsInputs);
    //     bytes32 jsGeneratedRoot = abi.decode(jsResult, (bytes32));

    //     // Calculate root using Murky
    //     bytes32 murkyGeneratedRoot = m.getRoot(leaves);
    //     assertEq(murkyGeneratedRoot, jsGeneratedRoot);
    // }
}
