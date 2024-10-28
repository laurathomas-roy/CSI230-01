#!bin/bash

file="/var/log/apache2/access.log"

#get files that indicate access to page2.html
results=$(cat "$file" | grep "GET /page2.html" | cut -d' ' -f1,7 | tr -d "/")

function pageCount(){
sitesAccessed=$(cat "$file" | cut -d' ' -f7 | sort | uniq -c | grep -v 408)
}

pageCount
echo "$sitesAccessed"
