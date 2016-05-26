# Version
- latest (wily)

### 1. Run bitmark-node container and start bitmark-webgui service
`docker run --detach --name bitmarkNode -it -p 2150:2150 -p 2140:2140 -p 2130:2130 bitmark/bitmark-node bitmark-webgui -c /etc/bitmark-webgui.conf start`
Note: port 2150 is for bitmark-mgmt web server, 2140 is for miner, 2130 is for btiarmkd rpc.

### 2. Use config to choose the chain

### 3. Make sure the bitcoin is running and go to `Issue&Transfer` page to setup bitmark-cli and bitmark-pay
Get the bitmark-pay address

### 4. Go back to bitmark config page, setup the config and start bitmarkd

### you can issue and transfer bitmark now!
