clear

function winLogRecords($days){
# Get login and logoff records from windows events
#Get the last 14 days
$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon `
-After (Get-Date).AddDays(-$days)

$loginoutsTable = @() #empty array to fill customly
for ($i = 0; $i -lt $loginouts.Count; $i++) {

#Creating event property value
$event = ""
if ($loginouts[$i].InstanceId -eq "7001") {$event = "Logon"}
if ($loginouts[$i].InstanceId -eq "7002") {$event = "Logoff"}

#Creating user property value
$user = $loginouts[$i].ReplacementStrings[1]
$SID = New-Object System.Security.Principal.SecurityIdentifier($user)
$userName = $SID.Translate([System.Security.Principal.NTAccount])

#Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].EventID; `
                                    "Event" = $event; `
                                     "User" = $userName.Value;
                                     }
} #end of for loop

$loginoutsTable
}

function startDownTimes($days){
$startshutdowns = Get-EventLog system -After (Get-Date).AddDays(-$days) `
| Where-Object {($_.EventID -eq "6006") -or ($_.EventID -eq "6005")}

$startshutdownsTable = @()
for ($i = 0; $i -lt $startshutdowns.Count; $i++) {

#Creating event property value
$event = ""
if ($startshutdowns[$i].EventId -eq "6005") {$event = "Start"}
if ($startshutdowns[$i].EventId -eq "6006") {$event = "Shut-Down"}

#Creating user property value
$user = "System"

#Adding each new line (in form of a custom object) to our empty array
$startshutdownsTable += [pscustomobject]@{"Time" = $startshutdowns[$i].TimeGenerated; `
                                            "Id" = $startshutdowns[$i].EventID; `
                                         "Event" = $event; `
                                          "User" = $user;
                                         }
}

$startshutdownsTable
}

#winLogRecords 80
#startDownTimes 80

#Get-EventLog system | Select source -Unique