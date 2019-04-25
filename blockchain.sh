if [ ! -d ~/.snowgem ]; then
  mkdir ~/.snowgem
fi

sudo apt-get update
sudo apt-get install \
      wget unzip curl libgomp1 -y

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs -y

wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index.zip.sf-part1 -O bc.sf-part1
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index.zip.sf-part2 -O bc.sf-part2
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index.zip.sf-part3 -O bc.sf-part3
wget -N https://github.com/Snowgem/Data/releases/download/0.0.1/blockchain_snowgem_index.zip.sf-part4 -O bc.sf-part4
npm install
node joinfile.js
rm bc.sf-part1
rm bc.sf-part2
rm bc.sf-part3
rm bc.sf-part4
unzip -o blockchain.zip -d ~/.snowgem
rm blockchain.zip
