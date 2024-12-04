## ETH1 Deposit Contract tests (WIP)

|     | test       | function                                                                                                         | Test |
| --- | ---------- | ---------------------------------------------------------------------------------------------------------------- | ---- |
| 1   | 🗂️ deposit | [`test_ValidDeposit_Success()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L21-L29)          | ✅   |
|     |            | [`test_InvalidSignature_Fail()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L43-L56)         | ✅   |
|     |            | [`test_InvalidSignatureLength_Fail()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L58-L71)   | ✅   |
|     |            | [`test_InvalidWithdraw_Fail()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L73-L86)          | ✅   |
|     |            | [`test_InvalidWithdrawLength_Fail()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L88-L101)   | ✅   |
|     |            | [`test_ValidPartialDeposit_Success()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L103-L128) | ✅   |
|     |            | [`test_ValidDepositCount_Success()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L130-L139)   | 🕯️   |
|     |            | [`test_ValidDepositRoot_Success()`](https://github.com/mmsaki/deposit/blob/main/test/deposit.t.sol#L140-L149)    | 🕯️   |
| 2   | 🗂️ merkle  |                                                                                                                  | 🗂️   |

<!-- > [Differential ffi testing](https://book.getfoundry.sh/forge/differential-ffi-testing?highlight=ffi#primer-the-ffi-cheatcode) -->

| key |         |
| --- | ------- |
| 🗂️  | Module  |
| ✅  | Passing |
| 🕯️  | WIP     |

## Validator Keys

Create keys:

```bash
./deposit new-mnemonic --num_validators 1 --chain holesky --eth1_withdrawal_address 0xFE948CB2122FDD87bAf43dCe8aFa254B1242c199
```

## Build Validator Transactions

```bash
./deposit partial-deposit --chain mainnet --withdrawal_address 0xFE948CB2122FDD87bAf43dCe8aFa254B1242c199 --keystore validator_keys/keystore-m_12381_3600_0_0_0-1733214572.json --amount 31 --output_folder . --regular-withdrawal
```

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
