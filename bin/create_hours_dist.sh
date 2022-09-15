#!/bin/bash

# Make a temporary file for storing usernames
Hour_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
client_dir=$1

# Go into the directory that has been taken as an argument
cd "$client_dir" || exit

## Concatenate the files containing all failed log-in attempts
## Extract the time-of-day data in the third coloumn
## Sort the time-of-day data so that the uniq command works
## Count the number of occurences for each time of day
## Structure the output in the form: data.addRow(['*hour-of-day*', *occurances*});
## Put it into the temp file
cat ./*/failed_login_data.txt | awk '{print $3}' | sort | uniq -c | awk 'match($0, / *([0-9]+) +([0-9]{2})/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > $Hour_file

# Use wrap contents, with the temporary file as the text input and hour-of-day distribution
# headers/footers, into a chart .html
../bin/wrap_contents.sh "$Hour_file" ../html_components/hours_dist ./hours_dist.html

# Delete the temporary file
rm $Hour_file
