#!/usr/bin/env bash

# Author : Keith Lehigh <klehigh@iu.edu>
# Pull feeds from SES.  output in Bro format.
# API key should be stored in $HOME/.cif of user running script

# space separated list of feeds
# colon separated feed name and confidence value.
FEEDS="infrastructure/botnet:85 domain/botnet:85 url/botnet:85"
# define path to our intel file
OUTFILE="/path/on/webserver/intel.txt"

# copy last output file to .bak extension, just in case
if [ -e $OUTFILE ];
then
	cp $OUTFILE $OUTFILE.bak
	# check return value and quit if we failed to copy
	if [ $? -ne 0 ];
	then
		echo "Failed to make backup of intel file.  Bailing out!"
		exit 1
	fi
fi

# truncate $OUTFILE via a lazy echo
echo -n >$OUTFILE

# download CIF data in Bro format
for pair in $FEEDS;
do
	# redefine our separator and assign split values to numbered variables
	IFS=:; set $pair
	cif -q $1 -c $2 -p bro >>$OUTFILE
	if [ $? -ne 0 ];
	then
		echo "Failed to download intel file. Bailing out!"
		exit 1
	fi
done

exit 0
