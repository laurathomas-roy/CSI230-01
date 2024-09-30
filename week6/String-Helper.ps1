<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


<# ******************************
# Create a function that checks if password meets certain parameters
****************************** #>
function checkPassword($password){
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)

    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    #at least 6 chars
    if($plainPassword.Length -ge 6){
        #one special char, one number, one letter
        if(($plainPassword -match "[^a-zA-Z0-9]") -and ($plainPassword -match "[0-9]") -and ($plainPassword -match "[a-zA-Z]")){
            return $true
        }
    }
    return $false
}