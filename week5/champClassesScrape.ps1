function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.23/courses-1.html

#get all the tr elements of the HTML document
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

#empty array to hold results
$fullTable = @()
for($i=1; $i -lt $trs.length; $i++){
    #get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    #want to separate start time and end time from one time field
    $Times = $tds[5].innerText.Split("-")

    $fullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                    "Title" = $tds[1].innerText; `
                                    "Days" = $tds[4].innerText; `
                                    "Time Start" = $Times[0]; `
                                    "Time End" = $Times[1]; `
                                    "Instructor" = $tds[6].innerText; `
                                    "Location" = $tds[9].innerText; 
                                   }

} #end of for loop

# List all the classes of Furkan Paligu
#return $fullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | `
#            where{ $_."Instructor" -ilike "Furkan Paligu" }

# list all the classes of JOYC 310 on Mondays, only display Class Code and Times
# sort by Start Time
return $fullTable | Where-Object{ ($_.Location -ilike "JOYC 310") -and ($_.Days -ilike "*M*") } | `
                    Sort-Object "Time Start" | Select-Object "Time Start", "Time End", "Class Code"

# Make a list of all the instructors that teach at least one course in 
# SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, make it unique
$ITSInstructors = $fullTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | Sort-Object "Instructor" -Unique `
                             | Select-Object "Instructor" 
#return $ITSInstructors

# group all the instructors by the number of classes they are teaching
#return $fullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
#           | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending


# return $fullTable
}

function daysTranslator($fullTable){
# go over every record in the table
for($i=0; $i -lt $fullTable.length; $i++){

    # empty array to hold days for every record
    $Days = @()

    # if you see "M" -> Monday
    if($fullTable[$i].Days -ilike "M*"){ $Days += "Monday" }

    # if you see "T" followed by T,W, or F -> Tuesday
    if($fullTable[$i].Days -ilike "*T[TWF]*"){ $Days += "Tuesday" }
    # if you only see "T" -> Tuesday
    ElseIf($fullTable[$i].Days -ilike "T"){ $Days += "Tuesday" }

    # if you see "W" -> Wednesday
    if($fullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

    # if you see "TH" -> Thursday
    if($fullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }

    # F -> Friday
    if($fullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }

    # make the switch
    $fullTable[$i].Days = $Days #????
}

return $fullTable
}

