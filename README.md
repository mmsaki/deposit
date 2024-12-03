## ETH2 Deposit Contract Tests

Mainnet address : [0x00000000219ab540356cbb839cbe05303d7705fa](https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code)

## TOC

- [x] Deposit 32 ETH test
- [ ] Deposit 31 ETH then 1 ETH test
- [ ] IncrementalMerkle Tree test
- [ ] Merkle Differential Fuzzing with Python
<!-- > [Differential ffi testing](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) -->

## Coverage (WIP)

|     | test    | function              | Test                                                                                                                                                   |
| --- | ------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | deposit | `deposit()`           | ✅ [`test_Deposit32ETH()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L18)                     |
|     |         |                       | ✅ [`testFuzz_Deposit_Bad_Signature()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L31)        |
|     |         |                       | ✅ [`testFuzz_Deposit_Bad_Withdraw_Address()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L46) |
|     |         |                       | ⏳ [`testDeposit_31ETH_Then_1ETH()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L61)           |
|     |         | `get_deposit_count()` | ⏳ [`test_Get_Deposit_Count()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L72)                |
|     |         | `get_deposit_root()`  | ⏳ [`test_Get_Deposit_Root()`](https://github.com/mmsaki/deposit/blob/cc75a9a4a188ff3b12608fe33afa4b05efc82c57/test/deposit.t.sol#L82)                 |

### Test

Run test with `forge test`

```ml
[⠊] Compiling...
No files changed, compilation skipped
test/deposit.t.sol:DepositTest
  ↪ Suite result: ok. 6 passed; 0 failed; 0 skipped; finished in 147.97ms (291.10ms CPU time)

Ran 6 tests for test/deposit.t.sol:DepositTest
[PASS] testDeposit_31ETH_Then_1ETH() (gas: 188)
[PASS] testFuzz_Deposit_Bad_Signature(bytes32,bytes32,bytes32) (runs: 257, μ: 72278, ~: 72278)
[PASS] testFuzz_Deposit_Bad_Withdraw_Address(uint8,address) (runs: 257, μ: 72228, ~: 72228)
[PASS] test_Deposit32ETH() (gas: 113320)
[PASS] test_Get_Deposit_Count() (gas: 232)
[PASS] test_Get_Deposit_Root() (gas: 211)
Suite result: ok. 6 passed; 0 failed; 0 skipped; finished in 147.97ms (291.10ms CPU time)

Ran 1 test suite in 722.27ms (147.97ms CPU time): 6 tests passed, 0 failed, 0 skipped (6 total tests)
```
