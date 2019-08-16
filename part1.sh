apt-get update
sudo apt-get install \
	build-essential pkg-config libc6-dev m4 \
	g++-multilib autoconf libtool ncurses-dev \
	unzip git python python-zmq zlib1g-dev wget \
	libcurl4-gnutls-dev bsdmainutils automake curl bc dc jq \
	wget unzip curl libgomp1 -y


if [ ! -f /swapfile ]; then

	fallocate -l 2G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile

	sh -c "echo '/swapfile none swap sw 0' >> /etc/fstab"
fi


# setup auto starting

#remove old one
if [ -f /lib/systemd/system/safecoinnode.service ]; then
  systemctl disable --now safecoinnode.service
  rm /lib/systemd/system/safecoinnode.service
fi

echo "Creating service file..."

service="echo '[Unit]
Description=SafeNodes daemon
After=network-online.target
[Service]
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=$HOME/safecoind
WorkingDirectory=$HOME/.safecoin
User=root
KillMode=mixed
Restart=always
RestartSec=10
TimeoutStopSec=10
Nice=-20
ProtectSystem=full

[Install]
WantedBy=multi-user.target' >> /lib/systemd/system/safecoinnode.service"

echo $service
sh -c "$service"
