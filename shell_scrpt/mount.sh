#!/bin/sh
df -h | awk '{print $6}'
