# motoko_token

## abstract

这是一个用 motoko 实现的的 token 代码。token 名为 Motoko Test Token，符号为 MKT，小数位为 4，总量为 1000_000 

## steps

terminal 1:
```
dfx start 
```

terminal 2:
```shell
npm install

dfx canister create motoko_token

dfx build motoko_token

dfx --identity default identity get-principal

DEFAULT_ID="principal \"$(dfx --identity default identity get-principal | sed 's/[\\(\\)]//g')\""

echo $DEFAULT_ID

# 下面安装命令里面的最后一个参数，改为 DEFAULT_ID 的输出
dfx canister install motoko_token --argument '("Motoko Test", 4, "MKT", 1000000, principal "l73xb-uaoom-uk6vy-yjmwy-ffdjj-tfbbn-wlsve-xxy7i-5d27t-6yh3t-fqe")' -m reinstall

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"
(10_000_000_000)

# dfx identity new alice_auth
ALICE_ID=$(dfx --identity alice_auth canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $ALICE_ID

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token transfer "($ALICE_ID, 1000000)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

# 溢出测试，下面的示例是在 Nat64 下面的输出，现在 Nat 了，不会报这个错。
dfx canister call motoko_token transfer "($ALICE_ID, 100_000_000_000_000_000_000)"
Invalid data: Unable to serialize Candid values: Candid parser error: number too large to fit in target type

dfx canister call motoko_token transfer "($ALICE_ID, 10_000_000_000)"
(false)

# dfx identity new bob_standard
BOB_ID=$(dfx --identity bob_standard canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $BOB_ID

dfx canister call motoko_token approve "($ALICE_ID, 50000)"

dfx --identity alice_auth canister call motoko_token transferFrom "($DEFAULT_ID, $BOB_ID, 50000)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token balanceOf "($BOB_ID)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"
```

## reference
1. ERC20: https://eips.ethereum.org/EIPS/eip-20