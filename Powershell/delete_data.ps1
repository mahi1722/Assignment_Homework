# to remove a data 
# use select-string - to filter and rewrite
#or
# use .NET StreamReader and StreamWriter
#or

$path = ".\demodata.csv"

try {
if (-not (test-path -path $path )){
throw "The file $path does not exist"
}

$data = import-csv -path $path -ErrorAction Stop

$filteredData = $data | Where-Object {$_.Name -ne "Jane Smith"}

$filteredData | export-csv -path $path -NoTypeInformation -ErrorAction Stop

write-host "Record successfully updated."

}
catch {
"Error: $_"
}


#run demo1 to reset the data.