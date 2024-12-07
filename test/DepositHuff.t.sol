// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

import {Test, console, stdJson} from "forge-std/Test.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import {IDepositContract} from "./IDepositContract.sol";

contract DepositHuffTest is Test {
    IDepositContract mainnetDeposit;
    IDepositContract holeskyDeposit;
    IDepositContract huffDeposit;

    function setUp() public {
        vm.deal(address(this), 32 ether);

        mainnetDeposit = IDepositContract(0x00000000219ab540356cBB839Cbe05303d7705Fa);
        holeskyDeposit = IDepositContract(0x4242424242424242424242424242424242424242);
        huffDeposit = IDepositContract(HuffDeployer.deploy("DepositHuff"));
    }

    // Prams encoding
    // MethodID: 0x22895118
    // [0]:  0x4   0000000000000000000000000000000000000000000000000000000000000080
    // [1]:  0x24  00000000000000000000000000000000000000000000000000000000000000e0
    // [2]:  0x44  0000000000000000000000000000000000000000000000000000000000000120
    // [3]:  0x64  7f05d633f19e32f0f3ef2753b28753d621a7a8b8935025028f680f4d8beb6d07 // signature
    // [4]:  0x84  0000000000000000000000000000000000000000000000000000000000000030 // pubkey.length
    // [5]:  0xa4  94aaa9040cc9f177e2a42d13f1988f27447afc70dc93484f2c86113054afe9b0
    // [6]:  0xc4  15cf5151cf8b23169e40668a667c1bce00000000000000000000000000000000
    // [7]:  0xe4  0000000000000000000000000000000000000000000000000000000000000020 // wc.length
    // [8]:  0x104 00776803baec1f3b7b111962437cd3d49315c1e7b777cfea345bdb7c1e9e0e71
    // [9]:  0x124 0000000000000000000000000000000000000000000000000000000000000060 // signature.length
    // [10]: 0x144 abe8885d2221e245cc3c153fcc2ea3e62762635d82c6060b91e097437e01464d
    // [11]: 0x164 c9f9f804e3ac1d895a2f557c819d48b60263e1147f30a6e6027b0aa73ab18601
    // [12]: 0x184 5acd1442d9b238139b183d80b654dc8cb044e3aeaa2ddc8fc093d092c8633fc9
    function testDepositCalldataLowLevel() public {
        bytes32 success;
        // vm.createSelectFork("mainnet");
        // address addr = address(mainnetDeposit);
        // vm.createSelectFork("holesky");
        // address addr = address(holeskyDeposit);
        address addr = address(huffDeposit);
        uint256 value = 32 ether;
        bytes memory raw = abi.encodePacked(
            bytes4(0x22895118),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000080),
            bytes32(0x00000000000000000000000000000000000000000000000000000000000000e0),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000120),
            bytes32(0x08345126fa802d58b2afb567bee5879c9d19dd228f099f5b271944bb64f1bacd),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000030),
            bytes32(0x92fbe9f4761625673fe21ce9db5c975d40f1f64e1b554ebb5bd71d0a5de13d30),
            bytes32(0xd8ed894cceb5487d193b9defb23eb94100000000000000000000000000000000),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000020),
            bytes32(0x010000000000000000000000fe948cb2122fdd87baf43dce8afa254b1242c199),
            bytes32(0x0000000000000000000000000000000000000000000000000000000000000060),
            bytes32(0x86d64339aca21ba35a7762fd8e40b8b56618f61546455efe2a6073954eff1884),
            bytes32(0x7e927fce031bd90fb77bfa88b46966ac0c20217ab40846bea8120306102b6b26),
            bytes32(0x108efe39acf5ead479e21f8686c120510b83ef83e7b1c43cf2ecaeca69fb6f56),
            string("hello, beacon panda!")
        );
        // TOOD: solc compiler uses calldatalength for calcualtions, maybe explore dos

        bytes32 len;
        assembly {
            len := mload(raw)
            success := call(gas(), addr, value, add(raw, 0x20), mload(raw), 0, 0)
        }
        console.log("length", uint256(len));
        assertEq(uint256(success), 1);
    }
}
