#!/bin/sh
iptables -nL | grep "10\|192" | awk '{print $4}'
