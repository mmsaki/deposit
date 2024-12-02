// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;

import {Script, console} from "forge-std/Script.sol";
import {DepositContract} from "../src/deposit.sol";

contract CounterScript is Script {
    DepositContract public deposit;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        deposit = new DepositContract();

        vm.stopBroadcast();
    }
}
