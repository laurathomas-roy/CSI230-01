#! /bin/bash

inFile="report.txt"
outFile="report.html"

echo "<html>" > "$outFile"
echo "<head>" >> "$outFile"
echo "<style> table, td {border: 1px solid black; } </style>" >> "$outFile"
echo "</head>" >> "$outFile"
echo "<body>" >> "$outFile"
echo "<br></br> Access logs with IOC indicators: <br></br>" >> "$outFile"
echo "<table>" >> "$outFile"
echo "<tbody>" >> "$outFile"

while read -r line; do
  ip=$(echo "$line" | awk '{print $1}')
  dateTime=$(echo "$line" | awk '{print $2}')
  page=$(echo "$line" | awk '{print $3}')

  echo "<tr><td>$ip</td><td>$dateTime</td><td>$page</td></tr>" >> "$outFile"
done < "$inFile"

echo "</tbody>" >> "$outFile"
echo "</table>" >> "$outFile"
echo "</body>" >> "$outFile"
echo "</html>" >> "$outFile"

sudo mv "$outFile" "/var/www/html/"
