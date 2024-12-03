## ETH2 Deposit Contract Tests

Mainnet address : [0x00000000219ab540356cbb839cbe05303d7705fa](https://etherscan.io/address/0x00000000219ab540356cbb839cbe05303d7705fa#code)

## TOC

- [x] Deposit 32 ETH test
- [ ] Deposit 31 ETH then 1 ETH test
- [ ] IncrementalMerkle Tree test
- [ ] Merkle Differential Fuzzing with Python
  > [Differential ffi testing](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode)

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
Ran 1 test for test/deposit.t.sol:DepositTest
[PASS] testFuzz_Deposit32ETH_Once() (gas: 79379)
Logs:
  1 0.0 Contract balance: 32 ETH
  1 0.1 Depositing 32000000000000000000 wei...
  1 0.2 Contract balance: 0 ETH
  0.3 Exit. ⚠️

Traces:
  [79379] DepositTest::testFuzz_Deposit32ETH_Once()
    ├─ [0] console::log(1, "0.0 Contract balance:", 32, "ETH") [staticcall]
    │   └─ ← [Stop]
    ├─ [59550] DepositContract::deposit{value: 32000000000000000000}(0x92fbe9f4761625673fe21ce9db5c975d40f1f64e1b554ebb5bd71d0a5de13d30d8ed894cceb5487d193b9defb23eb941, 0x010000000000000000000000fe948cb2122fdd87baf43dce8afa254b1242c199, 0x86d64339aca21ba35a7762fd8e40b8b56618f61546455efe2a6073954eff18847e927fce031bd90fb77bfa88b46966ac0c20217ab40846bea8120306102b6b26108efe39acf5ead479e21f8686c120510b83ef83e7b1c43cf2ecaeca69fb6f56, 0x08345126fa802d58b2afb567bee5879c9d19dd228f099f5b271944bb64f1bacd)
    │   ├─ emit DepositEvent(pubkey: 0x92fbe9f4761625673fe21ce9db5c975d40f1f64e1b554ebb5bd71d0a5de13d30d8ed894cceb5487d193b9defb23eb941, withdrawal_credentials: 0x010000000000000000000000fe948cb2122fdd87baf43dce8afa254b1242c199, amount: 0x0040597307000000, signature: 0x86d64339aca21ba35a7762fd8e40b8b56618f61546455efe2a6073954eff18847e927fce031bd90fb77bfa88b46966ac0c20217ab40846bea8120306102b6b26108efe39acf5ead479e21f8686c120510b83ef83e7b1c43cf2ecaeca69fb6f56, index: 0x0000000000000000)
    │   ├─ [84] PRECOMPILES::sha256(0x92fbe9f4761625673fe21ce9db5c975d40f1f64e1b554ebb5bd71d0a5de13d30d8ed894cceb5487d193b9defb23eb94100000000000000000000000000000000) [staticcall]
    │   │   └─ ← [Return] 0x21c02eebea68ca1698730cde96bb8df242e5a96d7c00ddbd9d04d93d22a24c9d
    │   ├─ [84] PRECOMPILES::sha256(0x86d64339aca21ba35a7762fd8e40b8b56618f61546455efe2a6073954eff18847e927fce031bd90fb77bfa88b46966ac0c20217ab40846bea8120306102b6b26) [staticcall]
    │   │   └─ ← [Return] 0x7618f66a7f2ab8e2d1384bc78e572c4de81fe3a1b95d248b25536528616af1c7
    │   ├─ [84] PRECOMPILES::sha256(0x108efe39acf5ead479e21f8686c120510b83ef83e7b1c43cf2ecaeca69fb6f560000000000000000000000000000000000000000000000000000000000000000) [staticcall]
    │   │   └─ ← [Return] 0x28b140e816aa523fbe260eff00408376a03584ac7e6623e020adce561abb3947
    │   ├─ [84] PRECOMPILES::sha256(0x7618f66a7f2ab8e2d1384bc78e572c4de81fe3a1b95d248b25536528616af1c728b140e816aa523fbe260eff00408376a03584ac7e6623e020adce561abb3947) [staticcall]
    │   │   └─ ← [Return] 0x65061ab152aec2d0b5c754c7cc99ba29f7fc0c53b712c85cdf76c16133049331
    │   ├─ [84] PRECOMPILES::sha256(0x21c02eebea68ca1698730cde96bb8df242e5a96d7c00ddbd9d04d93d22a24c9d010000000000000000000000fe948cb2122fdd87baf43dce8afa254b1242c199) [staticcall]
    │   │   └─ ← [Return] 0x335d54c82e9e6b02df0f8065b1f6202c843a4e0a8d70be2e52f11aa3bdddeb4f
    │   ├─ [84] PRECOMPILES::sha256(0x004059730700000000000000000000000000000000000000000000000000000065061ab152aec2d0b5c754c7cc99ba29f7fc0c53b712c85cdf76c16133049331) [staticcall]
    │   │   └─ ← [Return] 0xa693b73bc5a98ad7ad4da7fbb11a54b03d2df8cf6eb8befb223ba1cc88cc04ef
    │   ├─ [84] PRECOMPILES::sha256(0x335d54c82e9e6b02df0f8065b1f6202c843a4e0a8d70be2e52f11aa3bdddeb4fa693b73bc5a98ad7ad4da7fbb11a54b03d2df8cf6eb8befb223ba1cc88cc04ef) [staticcall]
    │   │   └─ ← [Return] 0x08345126fa802d58b2afb567bee5879c9d19dd228f099f5b271944bb64f1bacd
    │   └─ ← [Stop]
    ├─ [0] console::log(1, "0.1 Depositing", 32000000000000000000 [3.2e19], "wei...") [staticcall]
    │   └─ ← [Stop]
    ├─ [0] console::log(1, "0.2 Contract balance:", 0, "ETH") [staticcall]
    │   └─ ← [Stop]
    ├─ [0] console::log("0.3 Exit. ⚠\u{fe0f}") [staticcall]
    │   └─ ← [Stop]
    └─ ← [Stop]

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 1.75ms (532.48µs CPU time)

Ran 1 test suite in 698.69ms (1.75ms CPU time): 1 tests passed, 0 failed, 0 skipped (1 total tests)
```
