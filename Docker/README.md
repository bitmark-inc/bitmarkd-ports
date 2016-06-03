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
```
sudo docker run --detach --name bitmarkNode -p 2150:2150 -p 2140:2140 -p 2130:2130 bitmark/bitmark-node bitmark-webgui -c /etc/bitmark-webgui.conf start
```
The options meaning:
- `--detach`: run the container in background
- `--name bitmarkNode`: name the container bitmarkNode. You can modify the name
- `-p 2150:2150`: expose the container port 2150 to host port 2150. This port is for `bitamrk-webgui`. You can change the host port by replacing `2150:2150` to `port-u-want:2150`
- `-p 2140:2140`: expose the container port 2140. This port is for `cpu-miner`
- `-p 2130:2130`: expose the container port 2130. This port is for `bitmarkd`
- `bitmark-webgui -c /etc/bitmark-webgui.conf start`: command to start `bitmark-webgui`

Open the `https://localhost:2150` or `https://host-ip:2150` in browser and it will show you the login page. The default password is `bitmark-webgui`, you can reset it after you login.

Do not use Chrome, it will have a problem because we use self signed certification.

## Setup through web GUI
This section will tell you how to setup bitmark-cli, bitmark-pay and bitmarkd through `bitmark-webgui`. Before you start, make a decision of what bitmark chain you would like to use. Here are some requirements for different chain.
- `Local`: if you want to run your own bitmark system, choose this bitmark chain
- `Testing`: this chain provides you a playground of bitmark, like bitcoin testnet
- `Bitmark`: connect to real bitmark network, issue and transfer your digital property

### Local Chain
#### prerequisite
- start `bitmark-webgui` (check the container status is up)
- start `bitcoind` for the container, execute the command in terminal
```
sudo docker exec -d bitmarkNode bitcoind
```
- (optional) prepare a miner. You cannot do transfer bitmark without setting up a miner

#### step 1: Check and setup bitmarkd configuration
Login to the `bitmark-webgui`, it will show you the bitmarkd configuration, clicking `Config` button to go to the `edit` page and make changes.
- In `Bitmark RPC` section, check the chain is `Local`.
- In `Bitcoin` section, set the `username` to `btcuser`, the password to `p@ssw0rd`, and the address to `modifyThisAddressLater123456789`, and click `Save`. We will modify the address after the bitmark-pay setup is done.

#### step 2: Setup bitmark-cli, bitmark-pay
Go to the `Issue and Transfer Bitmark` page by clicking the `Issue&Transfer` in navigator bar:
- In `Setup` setction, you can choose any address which `Bitmark RPC` will listen in the `connect` field. If you did not modify the `Bitmark RPC` section in last step, you can put `127.0.0.1:2130` in this field.
- Fill out all fields. The length of password should greater than 8
- Click `submit`
- Wait for a while and then you will see the `Info` section.
- Copy the `Bitcoin Address`

#### step 3: Setup bitcoind address
Go to the main page by clicking the `bitmark` in navigator bar:
- Click `Config` to go the the `edit` page
- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field
- Click `Save`

#### step 4: Start bitmarkd
Go to the main page by clicking the `bitmark` in navigator bar:
- Check all the bitmark configuration again
- Click `start`

### Testing Chain
#### prerequisite
- start `bitmark-webgui`

#### step 1: Check and setup bitmarkd configuration
Login to the `bitmark-webgui`, it will show you the bitmarkd configuration, clicking `Config` button to go to the `edit` page and make changes.
- In `Bitmark RPC` section, check the chain, set it to `Testing`.
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

- Set the address to `modifyThisAddressLater123456789`, and click `Save`. We will modify the address after the `bitmark-pay` setup is done.

#### step 2: Setup bitmark-cli, bitmark-pay
Go to the `Issue and Transfer Bitmark` page by clicking the `Issue&Transfer` in navigator bar:
- In `Setup` setction, you can choose any address in `listen` field of `Bitmark RPC` section for the `connect` field. If you did not modify the `Bitmark RPC` section in last step, you can put `127.0.0.1:2130` in this field.
- Fill out all fields. The length of password should greater than 8
- Click `submit`
- Wait for a while and then you will see the info. Copy the `Bitcoin Address`

#### step 3: Setup bitcoind address
Go to the main page by clicking the `bitmark` in navigator bar:
- Click `Config` to go the the `edit` page
- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field
- Click `Save`

#### step 4: Start bitmarkd
Go to the main page by clicking the `bitmark` in navigator bar:
- Check all the bitmark configuration again
- Click `start`
- Waiting until the `mode` field in `Bitmark Info` becomes `Normal`

### Bitmark Chain
#### prerequisite
- start `bitmark-webgui`

#### step 1: Check and setup bitmarkd configuration
Login to the `bitmark-webgui`, it will show you the bitmarkd configuration, clicking `Config` button to go to the `edit` page and make changes.
- In `Bitmark RPC` section, check the chain, set it to `Bitmark`.
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

- Set the address to `modifyThisAddressLater123456789`, and click `Save`. We will modify the address after the bitmark-pay setup is done.

#### step 2: Setup bitmark-cli, bitmark-pay
Go to the `Issue and Transfer Bitmark` page by clicking the `Issue&Transfer` in navigator bar:
- In `Setup` setction, you can choose any address which `Bitmark RPC` will listen for the `connect` field. If you did not modify the `Bitmark RPC` section in last step, you can put `127.0.0.1:2130` in this field.
- Fill up the all fields. The length of password should greater than 8
- Click `submit`
- Wait for a while and then you will see the info. Copy the `Bitcoin Address`

#### step 3: Setup bitcoind address
Go to the main page by clicking the `bitmark` in navigator bar:
- Click `Config` to go the the `edit` page
- In `Bitcoin` setction, paste the `Bitcoin Address` you just copied into `address` field
- Click `Save`

#### step 4: Start bitmarkd
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
