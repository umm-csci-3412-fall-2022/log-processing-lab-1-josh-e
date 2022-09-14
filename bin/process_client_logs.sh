#!/bin/sh

# Take the directory that is being taken as an argument
client_dir=$1 

# Go into the directory
cd "$client_dir" || exit

# Concatenate the files in the directory, read the lines and find those with failed password attempts. 
# Of those lines, take the month, day, hour, username, and ip address and put them into a file: failed_login_data.text
cat ./*/*/* | awk 'match($0, /([a-zA-Z]+) *([0-9]{1,2}) *([0-9]{2}):[0-9]{2}:[0-9]{2} [a-zA-Z_]+ sshd\[[0-9]+]: Failed password for (invalid user )?([a-zA-Z0-9]+) from ([0-9.]+) port [0-9]+ ssh2/, groups) {print   groups[1] groups[2] groups[3] groups[5] groups[6]}' > failed_login_data.txt
