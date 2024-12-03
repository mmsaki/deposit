// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;

pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {stdJson} from "forge-std/StdJson.sol";
import {DepositContract} from "../src/deposit.sol";


contract DepositSetup is Test {
    DepositContract public deposit;
    using stdJson for string;
    string[] depositDataPaths;

    struct DepositData {
        bytes pubkey;
        bytes withdrawal_credentials;
        uint64 amount;
        bytes signature;
        bytes32 deposit_message_root;
        bytes32 deposit_data_root;
        bytes fork_version;
        string network_name;
    }

    function setUp() public virtual {
        deposit = new DepositContract();
        
        depositDataPaths.push("/partial_deposits/deposit_data-1733147074.json"); // 32 ETH deposit
        depositDataPaths.push("/partial_deposits/deposit_data-1733191448.json"); // 31 ETH deposit
        depositDataPaths.push("/partial_deposits/deposit_data-1733191529.json"); // 1 ETH deposit
    }

    function _getDepositData(string memory _path) public view returns (DepositData memory) {
        string memory root = vm.projectRoot();
        string memory path = string(abi.encodePacked(bytes(root), _path));
        string memory json = vm.readFile(path);
        
        bytes memory pubkey = vm.parseJsonBytes(json, ".[0].pubkey");
        bytes memory withdrawal_credentials = vm.parseJsonBytes(json, ".[0].withdrawal_credentials");
        uint64 amount = uint64(vm.parseJsonUint(json, ".[0].amount"));
        bytes memory signature =  vm.parseJsonBytes(json, ".[0].signature");
        bytes32 deposit_data_root = vm.parseJsonBytes32(json, ".[0].deposit_data_root");
        bytes32 deposit_message_root = vm.parseJsonBytes32(json, ".[0].deposit_message_root");
        bytes memory fork_version = vm.parseJsonBytes(json, ".[0].fork_version");
        string memory network_name = vm.parseJsonString(json, ".[0].network_name");

        DepositData memory depositData = DepositData({
            pubkey: pubkey,
            withdrawal_credentials: withdrawal_credentials,
            amount: amount,
            signature: signature,
            deposit_message_root: deposit_message_root,
            deposit_data_root: deposit_data_root,
            fork_version: fork_version,
            network_name: network_name
        });

        return depositData;
    }

    function get_32ETH_deposit_params() public view returns (DepositData memory) {
        return _getDepositData(depositDataPaths[0]);
    }

    function _getPartialDepositData() public view returns (DepositData[] memory) {
        DepositData[] memory deposits = new DepositData[](2);
        
        deposits[0] = _getDepositData(depositDataPaths[1]);
        deposits[1] = _getDepositData(depositDataPaths[2]);

        return deposits;
    }
}