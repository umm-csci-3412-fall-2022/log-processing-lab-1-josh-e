#!/bin/sh

client_dir=$1 

cd $client_dir

touch failed_login_data.txt

cat $client_dir/* | awk 'match($0, /([a-zA-Z]+) \([0-9]+) \([0-9]+):..:.. computer_name sshd[.....]: Failed password for invalid user \([a-zA-Z]+) from \([0-9.]+) .*/, groups) {print groups[1] groups[2] groups[3] groups[4] groups[5] "\n"}' > failed_login_data.txt

