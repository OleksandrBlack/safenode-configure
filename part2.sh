#!/bin/bash

# Args:						$1			$2				$3			$4
#						safekey			parentkey		safepass	safeheight
# example: ./part2.sh 	02b1...1924		0333b...f9a3	safepass	775000

confFile=~/.safecoin/safecoin.conf
killall -9 safecoind

cd ~

if [ ! -d ~/.safecoin ]; then
  mkdir .safecoin
fi

rm $confFile

if [ ! -f $confFile ]; then
  touch $confFile
  #write data
  rpcuser=$(gpw 1 30)
  echo "rpcuser="$rpcuser >> $confFile
  rpcpassword=$(gpw 1 30)
  echo "rpcpassword="$rpcpassword >> $confFile
  echo "addnode=explorer.safecoin.org" >> $confFile
  echo "addnode=explorer.deepsky.space" >> $confFile
  echo "addnode=dnsseed.local.support" >> $confFile
  echo "addnode=dnsseed.fair.exchange" >> $confFile
  echo "rpcport=8771" >> $confFile
  echo "port=8770" >> $confFile
  echo "listen=1" >> $confFile
  echo "server=1" >> $confFile
  echo "txindex=1" >> $confFile
  if echo $1; then
    echo "safekey=$1" >> $confFile
  fi
  if echo $2; then
    echo "parentkey=$2" >> $confFile
  fi
  if echo $3; then
    echo "safepass=$3" >> $confFile
  fi
  if echo $4; then
    echo "safeheight=$4" >> $confFile
  fi
fi

chmod +x ~/safenode-configure/fetch-params.sh

cd ~

./safenode-configure/fetch-params.sh

wget -N https://github.com/Fair-Exchange/safewallet/releases/download/data/binary_linux.zip -O ~/binary.zip
unzip -o ~/binary.zip -d ~
rm ~/binary.zip

if [ ! -d ~/.safecoin/blocks ]; then
  wget -N https://github.com/Fair-Exchange/safewallet/releases/download/data/blockchain_txindex.zip
  cd ~
  report_asgard_progress 'Unpacking data ...' 88
  unzip -o ~/blockchain_txindex.zip -d ~/.safecoin
  rm ~/blockchain_txindex.zip
fi

chmod +x ~/safecoind ~/safecoin-cli

#start
./safecoind -daemon > /dev/null

systemctl enable --now safecoinnode.service

sleep 5
x=1
echo "Wait for starting"
sleep 15
while true ; do
    echo "Wallet is opening, please wait. This step will take few minutes ($x)"
    sleep 1
    x=$(( $x + 1 ))
    ./safecoin-cli getinfo &> text.txt
    line=$(tail -n 1 text.txt)
    if [[ $line == *"..."* ]]; then
        echo $line
    fi
    if [[ $(tail -n 15 text.txt) == *"connections"* ]]; then
        echo
        echo "SafeNode successfully configured and launched!"
        echo
        echo "SafeKey: $1"
        echo "ParentKey: $2"
        echo "SafePass: $3"
        echo "SafeHeight: $4"
        break
    fi
	rm ~/text.txt
done
