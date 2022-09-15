#!/bin/bash

# Take the directory that we will be working out of as the only argument
client_dir=$1 

# Go into the directory that has been taken as an argument
cd $client_dir

## Concatenate the files containing all failed log-in attempts
## Extract the username data in the fourth column 
## Sort the usernames so that the uniq command works
## Count the number of occurances for each username
## Structure the output in the form: data.addRow(['*username*', *occurances*});
## Put it into a temp file
cat ./*/failed_login_data.txt | awk '{print $4}' | sort | uniq -c | awk 'match($0, / *([0-9]+) +([a-zA-Z0-9_\-]+)/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > tempfile.txt

