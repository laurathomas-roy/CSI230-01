#clear

function readConfiguration() {
$file = "C:\Users\champuser\Desktop\CSI230-01\week7\configuration.txt"
    $days = (Get-Content $file)[0]
    $time = (Get-Content $file)[1]
    $config = @()
    $config += [pscustomobject]@{"Days" = $days; `
                                 "ExecutionTime" = $time;  
                                }
    return $config
}

function changeConfiguration() {
$file = "C:\Users\champuser\Desktop\CSI230-01\week7\configuration.txt"
    $content = Get-Content $file
    Write-Host "Enter the number of days for which the logs will be obtained : "
    $days = Read-Host
    if($days -match "^\d+$"){
        $content[0] = $days
        $content | Set-Content $file

    }
    else{ Write-Host "Invaid entry. Please try again." }

    Write-Host "Enter the daily execution time of the script : "
    $time = Read-Host
    if($time -match "^([0-1]?[0-9]|2[0-3]):[0-5][0-9]\s[AP]M"){
        $content[1] = $time
        $content | Set-Content $file
        Write-Host "Configuration changed."
    }
    else{ Write-Host "Invaid entry. Please try again." }
}

function configurationMenu() {
    #create a menu with options
    $Prompt = "`n"
    $Prompt += "Please choose your operation:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $true

    while($operation){ 

        Write-Host $Prompt | Out-String
        $choice = Read-Host 

        if($choice -eq 3){
            #exit
            Write-Host "Goodbye" | Out-String
            exit
            $operation = $false 
        }

        elseif($choice -eq 1){
        #Show config (display as pscustomobject)
        $readConfig = readConfiguration
        Write-Host ($readConfig | Format-Table | Out-String)
        }
    
        elseif($choice -eq 2){
        #change config (ask user for new config, replace old with new)
        changeConfiguration
        }

        else {
            Write-Host "Invalid request. Please try again."
        }

    }
}

#configurationMenu