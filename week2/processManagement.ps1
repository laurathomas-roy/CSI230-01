clear

# Q1
#Get-Process | Where-object { $_.Name -ilike "C*" }

# Q2
#Get-Process | Where-object { $_.Path -notlike "*system32*" } | select Path

# Q3
#Get-Service | select Name, Status | Where-Object {$_.Status -eq "Stopped"} | `
 #Export-Csv -Path C:\Users\champuser\Desktop\CSI-230/week2\Processes.csv -NoTypeInformation 


# Q4
if (Get-Process chrome){Stop-Process -name chrome} else {Start-Process chrome -ArgumentList champlain.edu}