#! /bin/bash

if [ ! ${#} -eq 2 ]; then
echo "Usage: bash finalC2.bash <log-file> <ioc-file>"
exit;
fi

logFile=$1
iocFile=$2
outputFile="report.txt"
> "$outputFile"

while read -r ioc; do
  grep "$ioc" "$logFile" | cut -d' ' -f1,4,7 | tr -d '[]"' >> "$outputFile"
done < "$iocFile"
