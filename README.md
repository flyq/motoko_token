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

## steps

terminal 1:
```
dfx start 
```

terminal 2:
```
dfx canister create motoko_token

dfx build motoko_token

dfx canister install motoko_token --argument '("Motoko Token", 4, "MTT", 1000000)'

dfx canister call motoko_token callerPrincipal 


DEFAULT_ID=$(dfx --identity default canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')


dfx canister call motoko_token balanceOf "($DEFAULT_ID)"
(10_000_000_000)

ALICE_ID=$(dfx --identity alice_auth canister call motoko_token callerPrincipal | sed 's/[\\(\\)]//g')

echo $ALICE_ID

dfx canister call motoko_token balanceOf "($ALICE_ID)"

dfx canister call motoko_token transfer()

```
