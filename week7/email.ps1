function SendAlertEmail($Body){

$From = "laura.thomas-roy@mymail.champlain.edu"
$To = "laura.thomas-roy@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "xtav osgu xywa oedp" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential

}

#SendAlertEmail "Body of email"