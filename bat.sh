#!/bin/bash
#

echo "  ____  _            _                           _       _   _            _______          _  "
echo " |  _ \| |          | |        /\               | |     | | (_)          |__   __|        | | "
echo " | |_) | | ___   ___| | __    /  \   _ __   __ _| |_   _| |_ _  ___ ___     | | ___   ___ | | "
echo " |  _ <| |/ _ \ / __| |/ /   / /\ \ |  _ \ / _  | | | | | __| |/ __/ __|    | |/ _ \ / _ \| | "
echo " | |_) | | (_) | (__|   <   / ____ \| | | | (_| | | |_| | |_| | (__\__ \    | | (_) | (_) | | "
echo " |____/|_|\___/ \___|_|\_\ /_/    \_\_| |_|\__,_|_|\__, |\__|_|\___|___/    |_|\___/ \___/|_| "
echo "                                                    __/ |                                     "
echo "                                                   |___/                                      "

readiness_probe(){
  sleep 3
}

readiness_probe_fast(){
  sleep 1
}

#---------------------------------------------------------------------------------------------------
#                                 Read yaml file                                                    
#---------------------------------------------------------------------------------------------------

echo "Read yaml file and parse parameter values"
chmod +x yamlParser.sh

eval $(./yamlParser.sh config.yaml )
readiness_probe
#---------------------------------------------------------------------------------------------------
#                                 Setup database                                                    
#---------------------------------------------------------------------------------------------------

echo "Setup database"
echo "Choosing the BDC as mongodb"

display_msg "Install mongodb\n"
sudo apt update
sudo apt install -y mongodb
readiness_probe


#----------------------------------------------------------------------------------------------------
#                       Query blockchain and save files to the database                              
#----------------------------------------------------------------------------------------------------

npm install

echo "Mapping the data requested to match with the block index"
echo "Generate the necessary rules"
echo "Query the block index and acquire data"
readiness_probe_fast
echo "Process the data using the BAT processor"
readiness_probe_fast
echo "Load the data to the BDC"
readiness_probe_fast
echo "Retrieve data from the BDC "

node batRun.js 2>&1
readiness_probe
#---------------------------------------------------------------------------------------------------
#                      Create the model using the data acquired                                     
#---------------------------------------------------------------------------------------------------

echo "Create the model using the data acquired"

display_msg "Install pip\n"
sudo apt update
sudo apt install python-pip
readiness_probe
pip install pymongo


readiness_probe
python demandforecast.py




