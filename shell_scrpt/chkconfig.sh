#!/bin/sh
chkconfig|grep "1:off"|awk '{print $1" "$5}'
chkconfig |grep -A40 "xinetd based services:"|grep -v "xinetd based services:"|awk '{print $1" "$2}'
