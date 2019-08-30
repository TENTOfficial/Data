if [ ! -d ~/.snowgem ]; then
  mkdir ~/.snowgem
fi

sudo apt-get update
sudo apt-get install \
      wget unzip curl libgomp1 -y

if [ -f /lib/systemd/system/snowgem.service ]; then
	sudo systemctl disable --now snowgem.service
else
	echo "File not existed, OK"
  #create new one
  username=$(whoami)
  echo $username

  service=
  if [ "$username" = "root" ] ; then
    service="echo '[Unit]
  Description=Snowgem daemon
  After=network-online.target

  [Service]
  ExecReload=/bin/kill -HUP $MAINPID
  ExecStart=/root/snowgemd
  WorkingDirectory=/root/.snowgem
  User=root
  KillMode=mixed
  Restart=always
  RestartSec=10
  TimeoutStopSec=10
  Nice=-20
  ProtectSystem=full

  [Install]
  WantedBy=multi-user.target' >> /lib/systemd/system/snowgem.service"
  else
    service="echo '[Unit]
  Description=Snowgem daemon
  After=network-online.target

  [Service]
  ExecReload=/bin/kill -HUP $MAINPID
  ExecStart=/home/'$username'/snowgemd
  WorkingDirectory=/home/'$username'/.snowgem
  User='$username'
  KillMode=mixed
  Restart=always
  RestartSec=10
  TimeoutStopSec=10
  Nice=-20
  ProtectSystem=full

  [Install]
  WantedBy=multi-user.target' >> /lib/systemd/system/snowgem.service"
  fi
  echo $service
  sudo sh -c "$service"
fi

killall -9 snowgemd

rm ~/.snowgem/blocks ~/.snowgem/chainstate -r

wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index_879228.zip.sf-part1 -O bc.sf-part1
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index_879228.zip.sf-part2 -O bc.sf-part2
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index_879228.zip.sf-part3 -O bc.sf-part3
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index_879228.zip.sf-part4 -O bc.sf-part4
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index_879228.zip.sf-part5 -O bc.sf-part5

cat *.*part* > blockchain.zip
rm bc.sf-part1
rm bc.sf-part2
rm bc.sf-part3
rm bc.sf-part4
rm bc.sf-part5
unzip -o blockchain.zip -d ~/.snowgem
rm blockchain.zip

cd ~
#start
./snowgemd -daemon
sudo systemctl enable --now snowgem.service
