#!/bin/sh
if [ -n "`ls -l  /opt/web/wf -d`" ];then
	ls -l /opt/web/wf -d|cut -d " " -f 3|grep work
	rpm -qa |grep wf-1.0.6
