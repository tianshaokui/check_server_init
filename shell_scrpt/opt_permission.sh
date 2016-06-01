#!/bin/sh
ls -ld /opt/web | awk '{print $3" "$4" "$9}'
ls -ld /opt/soft | awk '{print $3" "$4" "$9}'
ls -ld /opt/ | awk '{print $3" "$4" "$9}'
ls -ld /opt/script | awk '{print $3" "$4" "$9}'
