#!/bin/bash

# Make a temporary file for storing usernames
Username_file=$(mktemp)

# Take the directory that we will be working out of as the only argument
computers_dir=$1 

# Go into the directory that has been taken as an argument
cd "$computers_dir" || exit

## Concatenate the files containing failed log-in attempts from all computers
## Extract the username data in the fourth column 
## Sort the usernames so that the uniq command works
## Count the number of occurances for each username
## Structure the output in the form: data.addRow(['*username*', *occurances*});
## Put it into the temp file
cat ./*/failed_login_data.txt | awk '{print $4}' | sort | uniq -c | awk 'match($0, / *([0-9]+) +([a-zA-Z0-9_\-]+)/, groups) {print "data.addRow([\x27" groups[2] "\x27, " groups[1] "]);"}' > "$Username_file"

# Use wrap contents, with the temporary file as the text input and username distritribution 
# headers/footers, into a pie chart .html
"$OLDPWD"/bin/wrap_contents.sh "$Username_file" "$OLDPWD"/html_components/username_dist username_dist.html

# Delete the temporary file
rm "$Username_file"

