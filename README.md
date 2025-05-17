## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.
# Foundry Fund Me

Kumzzy First repository

*[⭐️ | Foundry Fund Me](https://updraft.cyfrin.io/courses/foundry/foundry-fund-me/fund-me-project-setup)*

- [Foundry Fund Me](#foundry-fund-me)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
    - [Optional Gitpod](#optional-gitpod)
- [Usage](#usage)
  - [Deploy](#deploy)
  - [Testing](#testing)
    - [Test Coverage](#test-coverage)
  - [Local zkSync](#local-zksync)
    - [(Additional) Requirements](#additional-requirements)
    - [Setup local zkSync node](#setup-local-zksync-node)
    - [Deploy to local zkSync node](#deploy-to-local-zksync-node)
- [Deployment to a testnet or mainnet](#deployment-to-a-testnet-or-mainnet)
  - [Scripts](#scripts)
    - [Withdraw](#withdraw)
  - [Estimate gas](#estimate-gas)
- [Formatting](#formatting)
- [Additional Info:](#additional-info)
  - [Let's talk about what "Official" means](#lets-talk-about-what-official-means)
  - [Summary](#summary)
- [Thank you!](#thank-you)


## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


# 📦Getting started

### ✅Requirements
    - [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

### ⚡Quickstart
        ```
    git clone https://github.com/Cyfrin/foundry-fund-me-cu
    cd foundry-fund-me-cu
    make
    ```
### 🚀Usage
 🛠 Build
    ```
    forge build
    ```


### 🎯Deploy

    ```
    forge script script/DeployFundMe.s.sol
    ```

### ✅Testing

    We talk about 4 test tiers in the video. 

    1. Unit
    2. Integration
    3. Forked
    4. Staging


 This repo we cover #1 and #3. 


    ```
    forge test
    ```

or 

    ```
    // Only run test functions matching the specified regex pattern.

    ```
    "forge test -m testFunctionName" is deprecated. Please use 

    forge test --match-test testFunctionName
    ```

or

    ```
    forge test --fork-url $SEPOLIA_RPC_URL
    ```

### 🧪Test Coverage

    ```
    forge coverage
    ```

## 🧪Local zkSync 

    The instructions here will allow you to work with this repo on zkSync.

### (Additional) Requirements 

    In addition to the requirements above, you'll need:
    - [foundry-zksync](https://github.com/matter-labs/foundry-zksync)
    - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.0.2 (816e00b 2023-03-16T00:05:26.396218Z)`. 
    - [npx & npm](https://docs.npmjs.com/cli/v10/commands/npm-install)
    - You'll know you did it right if you can run `npm --version` and you see a response like `7.24.0` and `npx --version` and you see a response like `8.1.0`.
    - [docker](https://docs.docker.com/engine/install/)
    - You'll know you did it right if you can run `docker --version` and you see a response like `Docker version 20.10.7, build f0df350`.
    - Then, you'll want the daemon running, you'll know it's running if you can run `docker --info` and in the output you'll see something like the following to know it's running:
    ```bash
    Client:
    Context:    default
    Debug Mode: false
    ```

### Setup local zkSync node 

Run the following:

    ```bash
    npx zksync-cli dev config
    ```

And select: `In memory node` and do not select any additional modules.

    Then run:
    ```bash
    npx zksync-cli dev start
    ```

And you'll get an output like:
    ```
    In memory node started v0.1.0-alpha.22:
    - zkSync Node (L2):
    - Chain ID: 260
    - RPC URL: http://127.0.0.1:8011
    - Rich accounts: https://era.zksync.io/docs/tools/testing/era-test-node.html#use-pre-configured-rich-wallets
    ```

###  ℹ️ Additional Info
What does "Official" mean?
This is a learning project based on the Cyfrin course. Not production-ready.

### Summary
✅ First project using Foundry.

✅ Uses tests and scripts with Forge.

✅ Deploys and runs locally and with zkSync.

### 🙏 Thank You!
Thanks to Cyfrin and the Foundry community for great tooling and education!

### 💡 More updates coming soon...
 