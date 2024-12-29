$path = "MainData.csv"

function Backup {

if (Test-Path $path){

$timestamp = get-date -format "yyyyMMdd_HHmmss"
$backup_path = "$path.backup_$timestamp.csv"
Copy-Item -path $path -Destination $backup_path -ErrorAction Stop
write-host "Backup created at $backup_path"

}

else {
write-host "Backup couldn't be created."
}

}

function Ops {
param (
[string] $operation,
[hashtable]$record = @{}
)


try {

  # testing file path
 if(!(test-path $path)){
  throw "CSV file doesn't exist at $path."
 }

 switch ($operation.ToLower()){
 "create"{
 $data = import-csv -path $path
 $newRow = new-object PSObject -Property $record
 $data += $newRow
 $data | export-csv -path $path -NoTypeInformation
 write-host "Record added successfully."
 }

 "read"{
  $data = Import-Csv -Path $path
  Write-Host "Current Records:"
  $data | Format-Table
 }

 "update"{
  if (-not $Record["ID"]) {
  throw "Please provide an ID for the record to update."
  
  }
  $data = Import-Csv -Path $path
  $recordToUpdate = $data | Where-Object { $_.ID -eq $Record["ID"] }
  if ($recordToUpdate) {
  foreach ($key in $Record.Keys) {
  $recordToUpdate.$key = $Record[$key]
  }
  $data | Export-Csv -Path $path -NoTypeInformation
  Write-Host "Record updated successfully."
  } else {
  Write-Host "Record with ID $($Record["ID"]) not found."
  }
  }



  "delete"{
  if (-not $Record["ID"]) {
  throw "Please provide an ID for the record to delete."
  }
  $data = Import-Csv -Path $path
  $newData = $data | Where-Object { $_.ID -ne $Record["ID"] }
  $newData | Export-Csv -Path $path -NoTypeInformation
  Write-Host "Record deleted successfully."
  }


  default {
  Write-Host "Invalid operation. Use Create, Read, Update, or Delete."
  }
  }
  
 

}
catch {
 write-host "Error: $_"
}

finally {
$data = $null
[System.GC]::Collect()
}
}





#Main

try {
 if (!(test-path $path)){
 write-host "CSV file doesn't exist. Creating a new file."
 @("ID,Name,Age,Gender") | Out-File -filepath $path -Encoding utf8
 }

 #Making backup
Backup

Ops -operation "create" -record @{ID="1"; Name ="John"; Age = "20"; Gender = "Male"}

#Ops -operation "read"
#Ops -operation "update" -record @{ ID = "1"; Name = "John Doe"; Age = "31" }
#Ops -operation "delete" -record @{ ID = "1" }
#Ops -Operation "read"
}




catch{
Write-Host "Error: $_"
}

 