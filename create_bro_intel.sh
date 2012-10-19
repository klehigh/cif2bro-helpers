#!/usr/bin/env bash

# Author : Keith Lehigh <klehigh@iu.edu>
# Pull feeds from SES.  output in Bro format.
# Your API key should be stored in $HOME/.cif

# colon separated feed name and confidence value.
FEEDS="infrastructure/botnet:85 domain/botnet:85 url/botnet:85"
OUTFILE="/path/on/webserver/intel.txt"

# copy last output file to .bak extension, just in case
if [ -e $OUTFILE ];
then
	cp $OUTFILE $OUTFILE.bak
	if [ $? -ne 0 ];
	then
		echo "Failed to make backup of intel file.  Bailing out!"
		exit 1
	fi
fi

# let's truncate $OUTFILE via a lazy echo
echo >$OUTFILE

# download CIF data in Bro format
for pair in $FEEDS;
do
	IFS=:; set $pair
	cif -q $1 -c $2 -p bro >>$OUTFILE
	if [ $? -ne 0 ];
	then
		echo "Failed to download intel file. Bailing out!"
		exit 1
	fi
done

exit 0
