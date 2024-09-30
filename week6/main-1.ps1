. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - List at Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        $exists = checkUser($name)
        if($exists){
            Write-Host "User $name already exists."
            exit
        }

        $pwGood = checkPassword($password)
        if(!$pwGood){
            Write-Host "Invalid Password."
            exit
        }
    
        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $exists = checkUser($name)
        if(!$exists) {
            Write-Host "User does not exist."
            exit
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $exists = checkUser($name)
        if(!$exists) {
            Write-Host "User does not exist."
            exit
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        $exists = checkUser($name)
        if(!$exists) {
            Write-Host "User does not exist."
            exit
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        $exists = checkUser($name)
        if(!$exists) {
            Write-Host "User does not exist."
            exit
        }

        $days = Read-Host -Prompt "Please enter the number of days you would like logs for"
        $userLogins = getLogInAndOffs $days

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        $exists = checkUser($name)
        if(!$exists) {
            Write-Host "User does not exist."
            exit
        }

        $days = Read-Host -Prompt "Please enter the number of days you would like logs for"
        $userLogins = getFailedLogins $days #does this need to be changed?

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 9){
        $days = Read-Host -Prompt "Please enter the number of days you would like logs for"
        $userLogins = getFailedLogins $days
        $loginsByUser = $userLogins | Group-Object "User" `
                                    | Select-Object Name, Count `
                                    | Where-Object { $_.Count -ge 10 }
              
        Write-Host ($loginsByUser | Format-Table | Out-String)

    }


    else {
        Write-Host "Invalid request. Please try again."
    }
}