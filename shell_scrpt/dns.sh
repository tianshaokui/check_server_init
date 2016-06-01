#!/bin/sh
grep -v "^#" /etc/resolv.conf|awk '{print $2" "$3}'
