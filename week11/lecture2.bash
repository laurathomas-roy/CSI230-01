#!bash/bin

file="/var/log/apache2/access.log"

#count every curl access to the server from different IP addresses
function countingCurlAccess(){
	sitesAccessed=$(cat "$file" | grep curl | cut -d' ' -f1,12 | sort | uniq -c)
}

countingCurlAccess
echo "$sitesAccessed"
