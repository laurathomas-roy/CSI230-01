. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot parseApacheLogs.ps1)
. (Join-Path $PSScriptRoot processManagement.ps1)

#create a menu with options
clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Open an instance of champlain.edu if there is not another instance`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){ 

    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    if($choice -eq 5){
        #exit
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
    #display last ten apache logs
        ApacheLogs1 | Select-Object -Last 10
    }
    
    elseif($choice -eq 2){
    #display last ten failed logins for all users
        $days = Read-Host -Prompt "Please enter the number of days you would like logs for"
        $userLogins = getFailedLogins $days | Select-Object -Last 10

        Write-Host ($userLogins | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
    #display at-risk users
        $days = Read-Host -Prompt "Please enter the number of days you would like logs for"
        $userLogins = getFailedLogins $days
        $loginsByUser = $userLogins | Group-Object "User" `
                                    | Select-Object Name, Count `
                                    | Where-Object { $_.Count -ge 10 }
              
    Write-Host ($loginsByUser | Format-Table | Out-String)
    }

    elseif($choice -eq 4){
    #start chrome web browser and navigate it to champlain.edu - if no instance of chrome is running
        Open-Chrome
    }

    else {
        Write-Host "Invalid request. Please try again."
    }

}
