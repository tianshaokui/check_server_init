#!/bin/sh
if [  "`lspci|grep Mega`" ]; then
	/opt/MegaRAID/MegaCli/MegaCli64 -ldpdinfo -aall|grep -e "Name:Virtual" -e "RAID Level:" -e "Current Cache Policy:" -e "Firmware state:"
elif [ "`dmidecode |grep ProLiant`" ]; then
	hpssacli ctrl all show config detail|grep -e "Drive Authentication Status:" -e "Drive Write Cache:"|awk '{print $1" "$2" "$3" "$4}'
fi
