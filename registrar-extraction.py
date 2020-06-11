#!/usr/bin/python

#once you have registrant names, can do look up at: https://viewdns.info/reversewhois/
#todo: find free api tool to perform reverse whois lookups

import whois
import time

with open("domains.txt","r") as file:
	for line in file:
		perline = line.strip()
		result = whois.whois(perline)
		print("Domain:",perline," - ","Registrant Name:",result.registrant_name," - ","Registrant Contact Name:", result.registrant_contact_name," - ","Tech Contact Name:", result.tech_contact_name)
		# wait 2mins to avoid exceeding whois limit
		time.sleep(120)