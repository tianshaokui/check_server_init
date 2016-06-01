#!/bin/sh
if [ -n "`ls -l  /opt/scf -d`" ];then
	rpm -qa |grep scf-3.8.0
	ls -l /opt/scf -d|cut -d " " -f 3
