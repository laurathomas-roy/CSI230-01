. (Join-Path $PSScriptRoot funcsAndEventLogs.ps1)

clear

#get login and logoffs from last 15 days
$loginoutsTable = winLogRecords 15
$loginoutsTable

#get shut downs from last 25 days
$startshutdownsTable = startDownTimes 25
$startshutdownsTable