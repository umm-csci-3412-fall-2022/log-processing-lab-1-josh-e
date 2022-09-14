#!/bin/sh

client_dir=$1 

cd $client_dir

cat */*/* | awk 'match($0, /([a-zA-Z]+) *([0-9]{1,2}) *([0-9]{2}):([0-9]{2}):([0-9]{2}) [a-zA-Z_]+ sshd\[([0-9]+)\]: Failed password for (invalid user )?([a-zA-Z0-9]+) from ([0-9.]+) port ([0-9]+) ssh2/, groups) {print  groups[1] groups[2] groups[3] groups[8] groups[9]}' > failed_login_data.txt
