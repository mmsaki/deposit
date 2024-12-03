## ETH2 Deposit Contract Tests

Mainnet address : [0x00000000219ab540356cbb839cbe05303d7705fa](https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code)

## TOC

- [x] Test 32 ETH deposit
- [x] Test patial deposits e.g (31 Eth, then 1 Eth)
- [ ] Test incremental merkle tree (differential)
<!-- > [Differential ffi testing](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) -->

## Coverage (WIP)

|     | test    | function              | Test                                                                                                                                                   |
| --- | ------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | deposit | `deposit()`           | ✅ [`test_ValidDeposit_Success()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L17)             |
|     |         |                       | ✅ [`test_InvalidSignature_Fail`](https://github.com/mmsaki/deposit/blob/9739e0ce8c9c2a55bdfa758e41264d86011ae7cc/test/deposit.t.sol#L27-L41)          |
|     |         |                       | ✅ [`test_InvalidSignatureLength_Fail`](https://github.com/mmsaki/deposit/blob/9739e0ce8c9c2a55bdfa758e41264d86011ae7cc/test/deposit.t.sol#L42-L56)    |
|     |         |                       | ✅ [`test_InvalidWithdraw_Fail()`](https://github.com/mmsaki/deposit/blob/9739e0ce8c9c2a55bdfa758e41264d86011ae7cc/test/deposit.t.sol#L57-L71)         |
|     |         |                       | ✅ [`test_InvalidWithdrawLength_Fail()`](https://github.com/mmsaki/deposit/blob/9739e0ce8c9c2a55bdfa758e41264d86011ae7cc/test/deposit.t.sol#L72-86)    |
|     |         |                       | ✅ [`test_ValidPartialDeposit_Success()`](https://github.com/mmsaki/deposit/blob/9739e0ce8c9c2a55bdfa758e41264d86011ae7cc/test/deposit.t.sol#L86-L113) |
|     |         | `get_deposit_count()` | ⏳ [`test_ValidDepositCount_Success()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L84)        |
|     |         | `get_deposit_root()`  | ⏳ [`test_ValidDepositRoot_Success()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L94)         |
| 2   | merkle  |                       |                                                                                                                                                        |

### Test

Run test with `forge test`

```ml
[⠊] Compiling...
No files changed, compilation skipped
test/deposit.t.sol:DepositTest
  ↪ Suite result: ok. 8 passed; 0 failed; 0 skipped; finished in 537.00ms (1.76s CPU time)

Ran 8 tests for test/deposit.t.sol:DepositTest
[PASS] test_InvalidSignatureLength_Fail(bytes32,bytes32) (runs: 257, μ: 55770, ~: 55770)
[PASS] test_InvalidSignature_Fail(bytes32,bytes32,bytes32) (runs: 257, μ: 72277, ~: 72277)
[PASS] test_InvalidWithdrawLength_Fail(address) (runs: 257, μ: 55736, ~: 55736)
[PASS] test_InvalidWithdraw_Fail(uint8,address) (runs: 257, μ: 72228, ~: 72228)
[PASS] test_ValidDepositCount_Success() (gas: 212)
[PASS] test_ValidDepositRoot_Success() (gas: 191)
[PASS] test_ValidDeposit_Success() (gas: 113343)
[PASS] test_ValidPartialDeposit_Success() (gas: 196945)
Suite result: ok. 8 passed; 0 failed; 0 skipped; finished in 537.00ms (1.76s CPU time)

Ran 1 test suite in 1.11s (537.00ms CPU time): 8 tests passed, 0 failed, 0 skipped (8 total tests)
```
