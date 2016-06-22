# Version
- latest (wily)

# Introduction
`bitmark-node` is the easiest way for anyone to join the Bitmark network as a fully-validating peer. You can create, verify, and mine Bitmark transactions. Contains the following programs:
- bitmarkd: Main program
- bitmark-pay: Pay for transactions (with bitcoin)
- bitmark-cli: Command line interface to Main program
- bitmark-webgui: Web interface to Main program
- cpu-miner: (optional) Mine Bitmark blocks

## Chain
Bitmark provide three diffrent chains to let the `bitmarkd` join in. They are `local`, `testing`, `bitmark`.
- `local`: create private bitmark network and bitcoin
- `testing`: link to public test bitmark network, to pay the transactions, please contact us
- `bitmark`: link to public bitmark network, pay the transactions with real bitcoin

Here is a table to indicate what bitmark chain corresponds to what bitcoin chain
```
  bitmark chain |   bitcoin chain
=========================================
  local         |   regtest
  testing       |   regtest (from bitmark)
  bitmark       |   livenet
```

# Installation
It is simple to install `bitmark-node`, just install `Docker` and pull docker image `bitmark-node` from docker hub.

- [How to install docker](https://docs.docker.com/linux/)
- After you successfully installed docker, type this command to pull `bitmark-node` image
```
sudo docker pull bitmark/bitmark-node
```

## Start bitmark-webgui
`bitmark-webgui` is a package in `bitmark-node` image, it provides web interfaces for you to setup, issue, transfer and pay bitmark. We would start it while we run up the `bitmark-node` container.
Here is the command looks like, you can just copy-paste this command line, or change the option value as you want.

For Linux user
```
sudo docker run --detach --name bitmarkNode -p 2150:2150 -p 2140:2140 -p 2130:2130 bitmark/bitmark-node bitmark-webgui -c /etc/bitmark-webgui.conf start
```
For Mac user, you need to run this command to start the bitmark-webgui
```
sudo docker run --detach --name bitmarkNode -P -p 2150:2150 -p 2140:2140 -p 2130:2130 bitmark/bitmark-node bitmark-webgui -c /etc/bitmark-webgui.conf start
```

The options meaning:
- `--detach`: run the container in background
- `--name bitmarkNode`: name the container bitmarkNode. You can modify the name
- `-p 2150:2150`: expose the container port 2150 to host port 2150. This port is for `bitamrk-webgui`. You can change the host port by replacing `2150:2150` to `port-u-want:2150`
- `-p 2140:2140`: expose the container port 2140. This port is for `cpu-miner`
- `-p 2130:2130`: expose the container port 2130. This port is for `bitmarkd`
- `bitmark-webgui -c /etc/bitmark-webgui.conf start`: command to start `bitmark-webgui`

Open the `https://localhost:2150` or `https://host-ip:2150` or `https://dockerVM-ip:2150` in FireFox and it will show you the login page. The default password is `bitmark-webgui`, you can reset it after you login.

Some browsers (such as Chrome) will show you message like "This site can’t provide a secure connection"  because we use self signed certification. Please use FireFox and then click `Advanced` -> `Add Exception...` -> uncheck `Permanently store this exception` -> `Confirm Security Exception`. Then it will show you a login page.

## Setup through web GUI
Before you start, make a decision of what bitmark chain you would like to use. Here are some requirements for different chain.
- `Local`: if you want to run your own bitmark system, choose this bitmark chain
- `Testing`: this chain provides you a playground of bitmark, like bitcoin testnet
- `Bitmark`: connect to real bitmark network, issue and transfer your digital property

Note: For local chain, you might need to prepare a miner, otherwise you cannot do transfer bitmark without it

### step 1: Create New Bitmark Account or access existing one
If you don't have any bitmark account, please click the create button to create a new bitmark account. If you already have a bitmark account and want to access it, click the other button.

#### Create new bitmark account:
1. If you decide to create a new bitmark account, then you need to choose the bitmark chain you'd like to join first, then the bitmark-webgui will generate an keypair for you. Store the privateKey in a safe place, if you lost the privateKey, you will lost the account permanently and there is no way to get it back.
2. After you save your account privateKey, press next, and you will need to type a passcode to protect the privateKey for this session.
3. After you setup the passcode, you will go to the main page. The page shows default bitmarkd config. (go to step 2)

#### Access existing bitmark account:
This is a very simple page, select the chain you would like to join, fill in your privateKey and passcode, then you can press Go button and go to the main page.
Note: Make sure you access the privateKey to the same chain when the time the key was created

### step 2: Setup bitmark config
1. For `local` and `testing` chain, we need to get the bitcoin address to setup the bitmark first. It's simple to get the bitcoin address, click `Issue` in the nav bar and you will see there shows you a bitcoin address, please copy it.
2. Clicking `Config` button to go to the `edit` page and make changes.

#### for local chain:
- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field
- Click `Save`, then you will go back to the main page

#### for testing chain:
- In `Bitmark Peer` section, add `connect` field to connect to other `bitmarkd`.
```
           PublicKey                        |   Address
====================================================================
 .*}yF[u7o]viv.JrvLpC7pOW8Z+r^CHWnqALjTiy	|	172.16.23.227:2548
 ```

- In `Bitcoin` section, there are 3 ways to link to bitcoin:
1. `local-bitcoin`: link to your local bitcoin. The `bitcoind` must link to bitcoin network in bitmark
2. `proxy`: link to a bitcoin proxy. The proxy must link to bitcoin network in bitmark
3. `BitmarkInc-proxy`: proxy provided by Bitmark, connect to bitcoin network in bitmark

- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field
- Click `Save`

#### for bitmark chain:
- In `Bitmark Peer` section, add `connect` field to connect to other `bitmarkd`.
```
           PublicKey                        |   Address
====================================================================
 .*}yF[u7o]viv.JrvLpC7pOW8Z+r^CHWnqALjTiy	|	172.16.23.227:2548
 ```

- In `Bitcoin` section, there are 3 ways to link to bitcoin:

1. `local-bitcoin`: link to your local bitcoin. The `bitcoind` must link to bitcoin network in bitmark
2. `proxy`: link to a bitcoin proxy. The proxy must link to bitcoin network in bitmark
3. `BitmarkInc-proxy`: proxy provided by Bitmark, connect to bitcoin network in bitmark

- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field, or you can use your exsiting bitcoin address in livenet
- Click `Save`


### step 3: Start bitmarkd
Go to the main page by clicking the `bitmark` in navigator bar:
- Check all the bitmark configuration again
- Click `start`
- Waiting until the `mode` field in `Bitmark Info` becomes `Normal`

## Bitmark by yourself - Do issue and transfer
### environment checking
- make sure the bicoind is running
- the `bitmarkd` is running
- the `bitmarkd` status is `Normal`

### prerequisites for Local chain
Before you do issue, you need to send some bitcoin to your `Bitcoin Address`:
- get the bitmarkNode container bash
```
sudo docker exec -it bitmarkNode bash
```
- generate bitcoin first
```
bitcoin-cli generate 101
```
- send bitcoin to your `Bitcoin Address`
```
bitcoin-cli sendtoaddress <bitcoinAddress> 10.0
```
- generate 3 blocks to make your bitcoin address receive the coins
```
bitcoin-cli generate 3
```

### prerequisites for Testing Chain
- Asking bitmark to send some bitcoin to your address

### prerequisites for Bitmark
- Send some bitcoin to the bitcoin address

### issue/transfer bitmark through `bitmark-webgui`
Go to the `Issue and Transfer Bitmark` page by clicking the `Issue&Transfer` in navigator bar:
- Check the balance in `Info` section
- Fill up the fields in `Issue Asset` / `Transfer Bitmark` section and click `Submit`
