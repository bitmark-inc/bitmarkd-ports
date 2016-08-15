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
Bitmark provide three diffrent chains to let the `bitmarkd` join in. They are `testing`, `bitmark`.
- `testing`: link to public test bitmark network, to pay the transactions, please contact us
- `bitmark`: link to public bitmark network, pay the transactions with real bitcoin

Here is a table to indicate what bitmark chain corresponds to what bitcoin chain
```
  bitmark chain |   bitcoin chain
================+========================
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

## Login
When you see the login page, the default password is `bitmark-webgui`. You can modify the password later after you login.

## Start Bitmark Node
Choose the bitmark chain you would like to join.
- `testing`: this chain provides you a playground of bitmark, like bitcoin testnet
- `bitmark`: connect to real bitmark network, issue and transfer your digital property

After you start the bitmark node, you will send to the Node page that will show you the information and configuration of the bitmark node.

## Issue/Transfer bitmark through `bitmark-webgui`
Click the `Console` button on the navigator bar, you will see a console there. Type the following command:
`./bin/bitmark-onestep.sh`

- The script will ask you what bitmark chain you would like to use, please select the same chain of your bitmark node
- Please select the `Setup` service for the first time

### `Setup` service
- Please write down your private key, and send bitcoin to the `wallet address`. If your chain is `testnet`, please contact us to get bitcoins.

### `Issue` service
- The script will help you to issue a file and pay for the bitmark

### `Transfer` service
- The script will help you to transfer a txid to another specified user
