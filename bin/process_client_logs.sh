#!/bin/sh

client_dir=$1 

cd $client_dir

touch failed_login_data.txt

cat */*/* | awk 'match($0, /([a-zA-Z0-9 ]+):..:.. computer_name sshd[.....]: Failed password for invalid user \([a-zA-Z]+) from \([0-9.]+) */, groups) {print groups[1] groups[2] groups[3] "\n"}' > failed_login_data.txt

cat */*/* | awk 'match($0, /([a-zA-Z0-9 ]+):..:.. computer_name sshd[.....]: Failed password for \([a-zA-Z]+) from \([0-9.]+) */, groups) {print groups[1] groups[2] groups[3] "\n"}' > failed_login_data.txt

