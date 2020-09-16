#!/bin/bash

# Monitor Private Burp Collaborator log file and send webook to slack channel. 
# Run with: ./tail-slack.sh "burp.log" "https://hooks.slack.com/services/XXX..." &

CHANNEL="#burp-collaborator"

tail -n0 -F "$1" | while read LINE; do
	if [[ $LINE =~ "containing interaction IDs" || $LINE =~ "with interaction IDs" ]] ; then (echo "$LINE" | grep -e "$3") && curl -X POST --silent --data-urlencode \
    "payload={\"channel\": \"$CHANNEL\",\"text\": \"$(echo $LINE | sed "s/\"/'/g")\"}" "$2";fi
done
