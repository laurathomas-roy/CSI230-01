#! /bin/bash

# link to scrape
link="10.0.17.6/assignment.html"

# get with curl and tell curl to not give errors
fullPage=$(curl -sL "$link")

# utilize xmlstarlet to extract the tables from the page
tempData=$(echo "$fullPage" | xmlstarlet format | \
xmlstarlet sel -t -m "//table[@id='temp']/tr" -v "td[1]" -n)

pressureData=$(echo "$fullPage" | xmlstarlet format | \
xmlstarlet sel -t -m "//table[@id='press']/tr" -v "td[1]" -n)

timeData=$(echo "$fullPage" | xmlstarlet format | \
xmlstarlet sel -t -m "//table[@id='temp']/tr" -v "td[2]" -n)

# count num of lines in one of the outputs
lineCount=$(echo "$tempData" | wc -l)

# loop by number of lines and print data accordingly
for (( i=1; i<="$lineCount"; i++ ));
do
	temp=$(echo "$tempData" | head -n $i | tail -n 1)
	pressure=$(echo "$pressureData" | head -n $i | tail -n 1)
	times=$(echo "$timeData" | head -n $i | tail -n 1)

	echo -e "$pressure $temp $times"
done
