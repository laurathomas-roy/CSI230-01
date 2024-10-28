. "C:\Users\champuser\Desktop\CSI230-01\week6\Event-Logs.ps1"
. "C:\Users\champuser\Desktop\CSI230-01\week7\Configuration.ps1"
. "C:\Users\champuser\Desktop\CSI230-01\week7\email.ps1"
. "C:\Users\champuser\Desktop\CSI230-01\week7\Scheduler.ps1"

#obtaining config
$configuration = readConfiguration

#obtaining at risk users

$userLogins = getFailedLogins $configuration.Days
$Failed = $userLogins | Group-Object "User" `
                            | Select-Object Name, Count `
                            | Where-Object { $_.Count -ge 10 }

#send at risk users an email
SendAlertEmail($Failed | Format-Table | Out-String)

#setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)