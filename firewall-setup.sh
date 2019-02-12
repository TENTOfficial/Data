#!/bin/bash

#Color codes
RED='\033[0;91m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#Snowgem TCP port
PORT=16113

#Network Settings
echo -e "${GREEN}Installing Network Settings...${NC}"
{
sudo apt-get install ufw -y
} &> /dev/null
echo -ne "${RED}[##                 ]  (10%)\r"
{
sudo apt-get update -y
} &> /dev/null
echo -ne "${RED}[######             ] (30%)\r"
{
sudo ufw default deny incoming
} &> /dev/null
echo -ne "${YELLOW}[#########          ] (50%)\r"
{
sudo ufw default allow outgoing
sudo ufw allow ssh
} &> /dev/null
echo -ne "${YELLOW}[###########        ] (60%)\r"
{
sudo ufw allow $PORT/tcp
sudo ufw allow $RPC/tcp
} &> /dev/null
echo -ne "${YELLOW}[###############    ] (80%)\r"
{
sudo ufw allow 22/tcp
sudo ufw limit 22/tcp
} &> /dev/null
echo -ne "${GREEN}[#################  ] (90%)\r"
{
echo -e "${YELLOW}"
sudo ufw --force enable
echo -e "${NC}"
} &> /dev/null
echo -ne "${GREEN}[###################] (100%)\n"
echo -e "${YELLOW}Firewall is active and ports are opened correctly!${NC}"