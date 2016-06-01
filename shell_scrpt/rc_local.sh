#!/bin/sh
grep -v "^#" /etc/rc.local | grep -e "iptables.txt" -e "58sysctl.conf" -e "startup.sh"
