#. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot champClassesScrape.ps1)

$pageVisited = "index.html"
$httpCode = '200'
$browserName = "Chrome"

daysTranslator(gatherClasses)



#$output = Apache-Logs $pageVisited $httpCode $browserName
#Write-Output $output | Format-Table -AutoSize -Wrap

#$tableRecords = ApacheLogs1
#$tableRecords | Format-Table -AutoSize -Wrap