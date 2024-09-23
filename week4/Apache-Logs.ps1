clear
function Apache-Logs($pageVisited, $httpCode, $browserName) {

    $logs = Get-Content C:\xampp\apache\logs\access.log | Select-String $pageVisited | Select-String $httpCode | Select-String $browserName

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
    $ipsUnorg = $regex.matches($logs)

    $ips = @()
    for($i=0; $i -lt $ipsUnorg.Count; $i++){
      $ips += [pscustomobject]@{ "IP" = $ipsUnorg[$i].Value; }
}
   
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Sort-Object IP |Group IP
$counts | Select-Object Count, Name

return $ipsoftens
}