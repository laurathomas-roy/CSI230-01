clear
#list all of the apache logs of xampp
#Get-Content C:\xampp\apache\logs\access.log

#List only last 5 logs
#Get-Content C:\xampp\apache\logs\access.log -TotalCount 5

#display only logs that contain 404 or 400
#Get-Content C:\xampp\apache\logs\access.log | Select-String ' 400 '

#display only logs that do NOT contain 200 (OK)
#Get-Content C:\xampp\apache\logs\access.log | Select-String -NotMatch ' 200 '

#from every .log ext in the dir, only get logs w/ the word 'error'
#$A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'

#display last five elements from result array
#$A[-1..-5]

#Display only IP addresses for 404 records
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String '404'

#define regex for IP address
$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

#get $notfounds records that match to the regex
$ipsUnorganized = $regex.matches($notfounds)

#get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
  $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
#$ips | Where-Object { $_.IP -ilike "10.*" }

#count ips from 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group IP
$counts | Select-Object Count, Name