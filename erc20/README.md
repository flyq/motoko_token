# motoko_token

## abstract

This is a simple token. decimals is 3, totalSupply is 10_000_000, as 10_000 Token.

## steps

terminal 1:
```
cd erc20

sudo dfx start --clean
```

terminal 2:
```shell
cd erc20

sudo dfx canister create  --all

sudo dfx build

DEFAULT_ID="principal \"$(dfx --identity default identity get-principal | sed 's/[\\(\\)]//g')\""

echo $DEFAULT_ID

eval dfx canister install motoko_token --argument="'(\"Test Token\", \"Token\", 3, 10000000, $DEFAULT_ID)'"

dfx canister call motoko_token totalSupply 

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

# dfx identity new alice_auth
ALICE_ID="principal \"$(dfx --identity alice_auth identity get-principal | sed 's/[\\(\\)]//g')\""

echo $ALICE_ID

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token transfer "($ALICE_ID, 1000000)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

dfx canister call motoko_token transfer "($ALICE_ID, 10_000_000_000)"
(false)

# dfx identity new bob
BOB_ID="principal \"$(dfx --identity bob identity get-principal | sed 's/[\\(\\)]//g')\""

echo $BOB_ID

dfx canister call motoko_token approve "($ALICE_ID, 50000)"

dfx --identity alice_auth canister call motoko_token transferFrom "($DEFAULT_ID, $BOB_ID, 500)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token balanceOf "($BOB_ID)"

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"

dfx canister call motoko_token totalSupply 
```

## reference
1. ERC20: https://eips.ethereum.org/EIPS/eip-20