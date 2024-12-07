// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";

contract Code {
    function f() public pure returns (uint256) {
        return type(uint256).max;
    }

    function f(uint256 a) public pure returns (uint256) {
        return a;
    }
}

contract ReturndataOffsetExternalContractTest is Test {
    Code c;

    function setUp() public {
        c = new Code();
    }

    function testCallcodeDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := callcode(gas(), addr, 0, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testCallcodeDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := callcode(gas(), addr, 0, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testCallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := call(gas(), addr, 0, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testCallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := call(gas(), addr, 0, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testDelegatecallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := delegatecall(gas(), addr, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testDelegatecallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := delegatecall(gas(), addr, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testStaticcallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := staticcall(gas(), addr, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testStaticcallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(c);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := staticcall(gas(), addr, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }
}

contract ReturndataOffsetSelfcallTest is Test {
    function f() public pure returns (uint256) {
        return type(uint256).max;
    }

    function f(uint256 a) public pure returns (uint256) {
        return a;
    }

    function testCallcodeDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := callcode(gas(), addr, 0, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testCallcodeDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := callcode(gas(), addr, 0, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testCallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := call(gas(), addr, 0, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testCallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := call(gas(), addr, 0, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testDelegatecallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := delegatecall(gas(), addr, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testDelegatecallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := delegatecall(gas(), addr, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }

    function testStaticcallDataOffsetCopy() public returns (bool success, uint256 data) {
        bytes4 selector = 0x26121ff0; // f()
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            success := staticcall(gas(), addr, 0x00, 0x04, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, type(uint256).max);
    }

    function testStaticcallDataOffsetCopy(uint256 a) public returns (bool success, uint256 data) {
        bytes4 selector = 0xb3de648b; // f(uint256)
        address addr = address(this);

        uint256 returndataSize;

        assembly {
            mstore(0x00, selector)
            mstore(0x04, a)
            success := staticcall(gas(), addr, 0x00, 0x24, 0x100, 0x20)
            data := mload(0x100)
            returndataSize := returndatasize()
        }

        // call success
        assertTrue(success);
        assertEq(returndataSize, 0x20);
        assertEq(data, a);
    }
}
