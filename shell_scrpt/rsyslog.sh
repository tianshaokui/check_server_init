#!/bin/sh
md5sum /etc/rsyslog.conf|cut -d " " -f 1
