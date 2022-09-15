#!/bin/bash

textFile=$1 #Stores the content file as an argument
headerAndFooter=$2 #Stores the files of the headers and the footers as an argument
fileDestination=$3 #Stores the detination of the wrapped contents as an argument
 
# Use concatnate to put the textFile in between the header and the footer
# Subsequentally putting the result into the destination file
cat "${headerAndFooter}_header.html" "$textFile" "${headerAndFooter}_footer.html" > "$fileDestination"
