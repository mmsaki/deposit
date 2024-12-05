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

        depositDataPaths.push("/partial_deposits/deposit_data-1733147074.json"); // 32 ETH deposit holesky
        depositDataPaths.push("/partial_deposits/deposit_data-1733191448.json"); // 31 ETH deposit holesky
        depositDataPaths.push("/partial_deposits/deposit_data-1733191529.json"); // 1 ETH deposit  holesky
        depositDataPaths.push("/partial_deposits/deposit_data-1733214572.json"); // 32 ETH deposit mainnet
        depositDataPaths.push("/partial_deposits/deposit_data-1733215163.json"); // 31 ETH deposit mainnet
        depositDataPaths.push("/partial_deposits/deposit_data-1733215310.json"); // 1 ETH deposit  mainnet
    }

    function _getDepositData(string memory _path) public view returns (DepositData memory) {
        string memory root = vm.projectRoot();
        string memory path = string(abi.encodePacked(bytes(root), _path));
        string memory json = vm.readFile(path);

        bytes memory pubkey = vm.parseJsonBytes(json, ".[0].pubkey");
        bytes memory withdrawal_credentials = vm.parseJsonBytes(json, ".[0].withdrawal_credentials");
        uint64 amount = uint64(vm.parseJsonUint(json, ".[0].amount"));
        bytes memory signature = vm.parseJsonBytes(json, ".[0].signature");
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

    // Holesky: 32 ETH Params
    function _getHoleskyFullDepositParams() public view returns (DepositData memory) {
        return _getDepositData(depositDataPaths[0]);
    }

    // Mainnet: 32 ETH Params
    function _getMainnetFullDepositParams() public view returns (DepositData memory) {
        return _getDepositData(depositDataPaths[3]);
    }

    // Holesky: 31 ETH & 1 ETH Params
    function _getHoleskyPartialDepositParams() public view returns (DepositData[] memory) {
        DepositData[] memory deposits = new DepositData[](2);

        deposits[0] = _getDepositData(depositDataPaths[1]);
        deposits[1] = _getDepositData(depositDataPaths[2]);

        return deposits;
    }

    // Mainnet: 31 ETH & 1 ETH Params
    function _getMainnetPartialDepositParams() public view returns (DepositData[] memory) {
        DepositData[] memory deposits = new DepositData[](2);

        deposits[0] = _getDepositData(depositDataPaths[4]);
        deposits[1] = _getDepositData(depositDataPaths[5]);

        return deposits;
    }

    // Build fuzzed params
    function _generateFakeParams(
        bytes32 pubkey,
        bytes32 withdrawal_credentials,
        uint64 amount,
        bytes32 a,
        bytes32 b,
        bytes32 c
    ) public pure returns (DepositData memory) {
        bytes memory _amount = to_little_endian_64(amount / 1 gwei);

        // build bytes sig
        bytes memory signature = abi.encodePacked(a, b, c);
        bytes32 pubkey_root = sha256(abi.encodePacked(pubkey, bytes16(0), bytes16(0)));
        bytes32 signature_root =
            sha256(abi.encodePacked(sha256(abi.encodePacked(a, b)), sha256(abi.encodePacked(c, bytes32(0)))));
        bytes32 deposit_data_root = sha256(
            abi.encodePacked(
                sha256(abi.encodePacked(pubkey_root, withdrawal_credentials)),
                sha256(abi.encodePacked(_amount, bytes24(0), signature_root))
            )
        );

        DepositData memory depositData = DepositData({
            pubkey: abi.encodePacked(pubkey, bytes16(0)),
            withdrawal_credentials: abi.encodePacked(withdrawal_credentials),
            amount: amount,
            signature: signature,
            deposit_message_root: bytes32(0),
            deposit_data_root: deposit_data_root,
            fork_version: "",
            network_name: ""
        });

        return depositData;
    }

    function to_little_endian_64(uint64 value) public pure returns (bytes memory ret) {
        ret = new bytes(8);
        bytes8 bytesValue = bytes8(value);
        // Byteswapping during copying to bytes.
        ret[0] = bytesValue[7];
        ret[1] = bytesValue[6];
        ret[2] = bytesValue[5];
        ret[3] = bytesValue[4];
        ret[4] = bytesValue[3];
        ret[5] = bytesValue[2];
        ret[6] = bytesValue[1];
        ret[7] = bytesValue[0];
    }
}
