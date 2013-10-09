#!/usr/bin/env bash

# Copyright 2013 The Trustees of Indiana University
# Author : Keith Lehigh <klehigh@iu.edu>
# Pull feeds from SES.  output in Bro format.
# API key should be stored in $HOME/.cif of user running script

# space separated feeds. colon separated feed name and confidence value.
# adjust for your local site policy.
FEEDS="infrastructure/botnet:85 domain/botnet:85 url/botnet:85"
# define path to output intel file
# be careful about who can modify this file or its PATH, such as 
# web servers, etc.
OUTFILE="/path/to/intel.txt"

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

# set header and overwrite outfile
echo "#fields	indicator	indicator_type	meta.source	meta.desc	meta.url	meta.cif_impact	meta.cif_severity	meta.cif_confidence" >$OUTFILE

# download CIF data in Bro format
for pair in $FEEDS;
do
	# redefine our separator and assign split values to numbered variables
	IFS=:; set $pair
	# download feeds via cif and pass thru egrep to remove headers
	cif -q "$1" -c "$2" -p bro |egrep -v '^#' >>$OUTFILE
	# check our return code and fail if we get non-zero return code
	if [ $? -ne 0 ];
	then
		echo "Failed to download intel file. Bailing out!"
		exit 1
	fi
done

exit 0
