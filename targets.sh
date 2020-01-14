#!/bin/bash

# Simple script to grab bounty targets (which is updated every hour) and compare difference to identify new targets - then send slack notification

# Add your slack webhook here
HOOK=""

# Get updated list of targets from github
wget https://raw.githubusercontent.com/arkadiyt/bounty-targets-data/master/data/domains.txt > /dev/null 2>&1
mv domains.txt domains-$(date +"%m-%d-%Y-%T").txt

# Set variables for latest and previous file
file1=$(ls -td domains* | head -n 1)
file2=$(ls -td domaoms* | head -n 2 | tail -1)

# Check the difference between the latest and previous file and output to latest targets file
diff $file1 $file2 | grep '>' | sed 's/> *//' > latest-targets.txt

# Send slack notification of new targets
CHANNEL="#new-targets"
USERNAME="Targets-BOT"
MSG=$(cat latest-targets.txt)

PAYLOAD="payload={\"channel\": \"$CHANNEL\", \"username\": \"$USERNAME\", \"text\": \"$MSG\"}"

curl -X POST --data-urlencode "$PAYLOAD" "$HOOK"
