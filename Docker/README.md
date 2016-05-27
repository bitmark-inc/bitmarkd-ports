# Version
- latest (wily)

### 1. Run bitmark-node container and start bitmark-webgui service
-`docker run --detach --name bitmarkNode -it -p 2150:2150 -p 2140:2140 -p 2130:2130 bitmark/bitmark-node bitmark-webgui -c /etc/bitmark-webgui.conf start`
- Open `https://localhost:2150` in firefox

Note: port 2150 is for bitmark-mgmt web server, 2140 is for miner, 2130 is for btiarmkd rpc.


### 2. Use config button to choose the chain

### 3. Setup bitmark-cli and bitmark-pay

#### 3.1. Setup bitcoind peer in bitmark-pay config file and check bitcoind peer is running
##### 3.1.1. For local chain
- Run command `sudo docker exec -d bitmarkNode bitcoind` to start local bitcoind
##### 3.1.2. For testing or bitmark chain
- login the container through `sudo docker exec -it bitmarkNode bash`
- setup your bitcoind peer in `/home/bitmark/config/bitmark-pay/bitmark-pay-<chain_name>.xml`
- make sure the bitcoind peer in your bitmark-pay config file is running

#### 3.2. Go to `Issue&Transfer` page in browser
- Fill out all the columns, then submit. Waiting the process done
- Copy the `Bitcoin Address` if you want to utilize it in `bitmarkd`

Note: If the bitmark-pay process cannot success, go to check your bitmark-pay config and also the bitcoind status

### 4. Go to `bitmark`(main) page in browser
- Check out the bitmark config file
- Use `Config` button to modify it
- You can use the `Bitcoin Address` you just get in step 3.2 and paste it in the bitcoin section
- Press `Save&Start` to save the config file and start `bitmarkd`

### 5. Welcome to join bitmark
- you can issue and transfer bitmark in `Issue&Transfer` page now!
