#! /bin/bash

link="10.0.17.6/IOC.html"

fullPage=$(curl -sL "$link")

echo "$fullPage" | xmlstarlet format | \
xmlstarlet sel -t -m "//table/tr[td]" -v "td[1]" -n > IOC.txt
