#!/bin/bash

# Make two temporary files for storing IP addresses and country origin
Country_file=$(mktemp)
IP_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
computers_file=$1

# Go into the directory that has been taken as an argument
cd "$computers_dir" || exit

## Concatenate the files containing failed log-in attempts from all computers
## Extract the IP address data in the fifth column
## Sort the IP address data so that the join function works
cat ./*/failed_login_data.txt | awk '{print $5}' | sort > $IP_file

## Join temporary IP file with country IP address comparison group
## Extract the country data from the 2nd coloumn 
## Sort the country data so that the uniq command works
## Count the number of occurances for each country
## Structure the output in the form: data.addRow(['*country*', *ocurrances*]);
## Put it into the country temp file
join $IP_file ../etc/country_IP_map.txt | awk {print $2} | sort | uniq -c | awk 'match($0, / *([0-9]+) +([A-Z]{2})/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > $Country_file

# Use wrap contents, with the temporary file as the text input and country distribution 
# headers/footers, into a map .html
../bin/wrap_contents.sh "$Country_file" ../html_components/country_dist ./country_dist.html
