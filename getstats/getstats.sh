#!/bin/sh
#
# Small script to list all statistics/counters in a running Kamailio
# Requires (apart from RPC support) the counter module and the statistics module
# The SNMPstats module also generate a lot of statistics
#
# (C) Edvina AB, Sollentuna, Sweden
#     Olle E. Johansson (oej@edvina.net)
#
KAMCMD="/usr/local/sbin/kamcmd -s /tmp/kamailio_lab.ctl "
echo "*** Listing all groups"
STATGRP="`$KAMCMD cnt.grps_list`"
echo "*** Listing all variables per groups"
for grp in $STATGRP
do
	echo "*** $grp "
	# Get all the stats names
	STATNAMES=`$KAMCMD cnt.var_list $grp`
	for stat in $STATNAMES
	do
		# Get description
		DESC=`$KAMCMD cnt.help $grp $stat`
		VALUE=`$KAMCMD cnt.get $grp $stat`
		echo "     $stat : $VALUE   ($DESC) "
	done
done
