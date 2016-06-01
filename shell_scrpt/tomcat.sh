#!/bin/sh
rpm -qa |egrep -e 'tomcat.*-7.0.42'
ps aux |grep /opt/soft/tomcat|grep -v grep
