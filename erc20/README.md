# motoko_token

## abstract

这是一个用 motoko 实现的的 token 代码。token 名为 motoko_token，符号为 MT，小数位为 0，总量为 1000

为了适用容器间调用，改版

## steps

terminal 1:
```
dfx start 
```

terminal 2:
```shell
dfx canister create motoko_token

dfx build motoko_token

dfx canister install motoko_token -m reinstall

dfx --identity default identity get-principal

DEFAULT_ID="principal \"$(dfx --identity default identity get-principal | sed 's/[\\(\\)]//g')\""

echo $DEFAULT_ID

# dfx identity new alice_auth
ALICE_ID=$(dfx --identity alice_auth canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $ALICE_ID

dfx canister call motoko_token init '("motoko_token", "MT", 0, 1000)'

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token transfer "($ALICE_ID, 1000000)"


dfx canister call motoko_token totalSupply 

dfx canister call motoko_token init  '("Motoko Test Token", "MTT", 0, 1000)'

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

dfx canister call motoko_token transfer "($ALICE_ID, 10_000_000_000)"
(false)

dfx canister call motoko_token transfer "($ALICE_ID, 10)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"
dfx canister call motoko_token balanceOf "($ALICE_ID)"


# dfx identity new bob_standard
BOB_ID=$(dfx --identity bob_standard canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $BOB_ID

dfx canister call motoko_token approve "($ALICE_ID, 50000)"

dfx --identity alice_auth canister call motoko_token transferFrom "($DEFAULT_ID, $BOB_ID, 500)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token balanceOf "($BOB_ID)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

➜  dswap git:(flyq) ✗ eval sudo dfx canister install token1 --argument="'(\"t1\",\"t1\",0,10000,$a)'"
```

## reference
1. ERC20: https://eips.ethereum.org/EIPS/eip-20