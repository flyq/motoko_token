# motoko_token

Welcome to your new motoko_token project and to the internet computer development community. By default, creating a new project adds this README and some template files to your project directory. You can edit these template files to customize your project and to include your own code to speed up the development cycle.

To get started, you might want to explore the project directory structure and the default configuration file. Working with this project in your development environment will not affect any production deployment or identity tokens.

To learn more before you start working with motoko_token, see the following documentation available online:

- [Quick Start](https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html)
- [SDK Developer Tools](https://sdk.dfinity.org/docs/developers-guide/sdk-guide.html)
- [Motoko Programming Language Guide](https://sdk.dfinity.org/docs/language-guide/motoko.html)
- [Motoko Language Quick Reference](https://sdk.dfinity.org/docs/language-guide/language-manual.html)

If you want to start working on your project right away, you might want to try the following commands:

```bash
cd motoko_token/
dfx help
dfx config --help
```
:warning: IMPORTANT NOTE: This code is just a sample for learning purposes. It is not audited and reviewed for production use cases. You can expect bugs and security vulnerabilities. Do not use it as-is in real applications.

## abstract

这是一个用 motoko 实现的的 token 代码。token 名为 Motoko Test Token，符号为 MKT，小数位为 4，总量为 1000_000 

## steps

terminal 1:
```
dfx start 
```

terminal 2:
```shell
dfx canister create motoko_token

dfx build motoko_token

dfx canister install motoko_token --argument '("Motoko Test Token", 4, "MKT", 1000000)'

dfx canister call motoko_token callerPrincipal 


DEFAULT_ID=$(dfx --identity default canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $DEFAULT_ID

dfx canister call motoko_token balanceOf "($DEFAULT_ID)"
(10_000_000_000)

dfx identity new alice_auth

ALICE_ID=$(dfx --identity alice_auth canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $ALICE_ID

dfx canister call motoko_token balanceOf "($ALICE_ID)"
(10_000_000_000)

# 发现获取余额的逻辑有问题，更新容器

dfx build motoko_token

dfx canister install motoko_token --argument '("Motoko Token", 4, "MTT", 1000000)' -m upgrade

dfx canister call motoko_token balanceOf "($ALICE_ID)"
(0)

dfx canister call motoko_token transfer "($ALICE_ID, 1000000)"

dfx canister call motoko_token balanceOf "($ALICE_ID)"

# 发现转账逻辑有问题，重新安装容器

dfx build motoko_token

dfx canister install motoko_token --argument '("Motoko Token", 4, "MTT", 1000000)' -m reinstall

# 重新安装后余额为0
dfx canister call motoko_token balanceOf "($ALICE_ID)"
(0)

dfx canister call motoko_token transfer "($ALICE_ID, 10000)"

# 溢出测试
dfx canister call motoko_token transfer "($ALICE_ID, 100_000_000_000_000_000_000)"
Invalid data: Unable to serialize Candid values: Candid parser error: number too large to fit in target type

dfx canister call motoko_token transfer "($ALICE_ID, 10_000_000_000)"
(false)

# 
dfx canister install motoko_token --argument '("Motoko Token", 4, "MTT", 1000000)' -m upgrade

BOB_ID=$(dfx --identity bob_standard canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')



```

## reference
1. ERC20: https://eips.ethereum.org/EIPS/eip-20