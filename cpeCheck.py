#!/usr/bin/env python


import csv
import urllib
import argparse
import gzip
import os
from urllib2 import urlopen, URLError, HTTPError

# Thanks to https://stackoverflow.com/questions/4028697/how-do-i-download-a-zip-file-in-python-using-urllib2
# for this function.
def dlfile(url):
    # Open the url
    try:
        f = urlopen(url)
        print "downloading " + url

        # Open our local file for writing
        with open(os.path.basename(url), "wb") as local_file:
            local_file.write(f.read())

    #handle errors
    except HTTPError, e:
        print "HTTP Error:", e.code, url
    except URLError, e:
        print "URL Error:", e.reason, url

def get_cpe_dictionary():
	dlfile("https://static.nvd.nist.gov/feeds/xml/cpe/dictionary/official-cpe-dictionary_v2.3.xml.gz")

def find_cpe(cpe_id):
	for line in gzip.open("official-cpe-dictionary_v2.3.xml.gz"):
		if cpe_id in line:
			return
	return "Not found"

def parse_args():
	parser = argparse.ArgumentParser()
	parser.add_argument('-i', dest='csv_file', action='store', required=True,
				help='cpe-info report')
	return parser.parse_args()


def __main__():
	args = parse_args()
	print "Retrieving CPE dictionary ..."
	get_cpe_dictionary()

	missing_cpe = []
	update_cpe = []
	num_matches = 0
	print "Checking for EXACT CPE matches..."
	with open(args.csv_file) as cpe_file:
		cpe_list = csv.reader(cpe_file)
		for cpe in cpe_list:
			if "CPE ID" not in cpe[0]:
				result = find_cpe(cpe[0])
				if result:
					cpe_no_version = cpe[0].split(":")[0]+":"+cpe[0].split(":")[1]+":"+cpe[0].split(":")[2]+":"+cpe[0].split(":")[3]+":"+cpe[0].split(":")[4]
					result = find_cpe(cpe_no_version)
					if result:
						missing_cpe.append(cpe[0])
					else:
						update_cpe.append(cpe[0])
				else:
					num_matches += 1
	print (" FOUND[%d]" % num_matches)

	num_matches = 0
	print "**** The below CPEs need a new version added ****"
	for cpe in update_cpe:
		print cpe
		num_matches += 1
	print (" FOUND[%d]" % num_matches)

	num_matches = 0
	print "\n**** The below CPEs are missing ***"
	for cpe in missing_cpe:
		print cpe
		num_matches += 1
	print (" FOUND[%d]" % num_matches)

__main__()
