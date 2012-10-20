#!/usr/bin/env bash

# Author : Keith Lehigh <klehigh@iu.edu>
# download Bro intel file and overwrite current file.

# URL for our intel file
WEBPATH='https://path/to/web/intel.txt'

# Location of Bro Intel File
INTELFILE='/usr/local/bro/share/bro/site/intel.txt'

# if, for some reason, you do not want to use curl to download the intel file
# uncomment and define DLTOOL and DLARGS 
#DLTOOL=blah
#DLARGS="-b -l -a -h"

# run download tool and overwrite existing intel file
${DLTOOL:-curl} ${DLARGS:--s} $WEBPATH >$INTELFILE

# check our return value and bail if we fail
if [ $? -ne 0 ];
then
	echo "Download of Bro Intel failed!  Exiting!"
	exit 1;
fi

exit 0
