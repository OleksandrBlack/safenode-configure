### This script is for root user

### Install dependencies

On Ubuntu/Debian-based systems:
```
sudo apt-get update
```
```
sudo apt-get install \
      build-essential pkg-config libc6-dev m4 g++-multilib \
      autoconf libtool ncurses-dev unzip git python python-zmq \
      zlib1g-dev wget bsdmainutils automake curl gpw npm
```

### NOTE
```
You don't need to download blockchain manually, latest script will do it for you
```

### Download setup file
```
git clone https://github.com/Fair-Exchange/safenode-configure
cd safenode-configure
chmod +x part1.sh part2.sh
```

### Create swap
```
sudo su
```
Type your password if needed.

Run the following commands:

```
./part1.sh
```

Press ```CTRL``` + ```D```

### Configure SafeNodes

For example:
- Your safekey is ```02d7ea031dd3eb12c78629b89a3a6e033545ce836b843b5251bd16a333fac5d06d```
*Need to take here https://safenodes.org/
- Your parentkey is ```0333b9796526ef8de88712a649d618689a1de1ed1adf9fb5ec415f31e560b1f9a3```
*Default value. May be changed
- Your safepass is ```YdPyBdM93Izv```
*Can be generated or invented
- Your safeheight is ```775000```
*Сurrent block height. You can see it here https://explorer.safecoin.org/

You'll need to run this command:
```
./part2.sh 02d7ea031dd3eb12c78629b89a3a6e033545ce836b843b5251bd16a333fac5d06d 0333b9796526ef8de88712a649d618689a1de1ed1adf9fb5ec415f31e560b1f9a3 YdPyBdM93Izv 775000
```

After it's finished, you'll receive this data:
```
SafeNode successfully configured and launched!

SafeKey: 02d7ea031dd3eb12c78629b89a3a6e033545ce836b843b5251bd16a333fac5d06d
ParentKey: 0333b9796526ef8de88712a649d618689a1de1ed1adf9fb5ec415f31e560b1f9a3
SafePass: YdPyBdM93Izv
SafeHeight: 775000

```
Safecoinnode service is created on your server. It will automatically start your node in case of reboot.

View service status:
```
systemctl status safecoinnode
```

Stop service:
```
systemctl stop safecoinnode
```

Start service:
```
systemctl start safecoinnode
```

Disable service:
```
systemctl disable safecoinnode
```