#!/usr/bin/env bash

# download Bro intel file and update current file.
# Author : Keith Lehigh <klehigh@iu.edu>

# URL for our intel file
WEBPATH='https://path/to/web/intel.txt'

# Location of Bro Intel File
INTELFILE='/usr/local/bro/share/bro/site/intel.txt'

curl -s $WEBPATH >$INTELFILE

if [ $? -ne 0 ];
then
	echo "Download of Bro Intel failed!  Exiting!"
	exit 1;
fi

exit 0
