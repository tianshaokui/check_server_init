#!/bin/sh
for file in `ls /etc/yum.repos.d/`;do
	md5sum /etc/yum.repos.d/$file
done
