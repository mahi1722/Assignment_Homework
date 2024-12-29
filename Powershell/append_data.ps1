$newRow = [PSCustomObject]@{ID = 6; Name = "Alice Brown"; Age = 29}

$newRow | export-csv -path ".\demodata.csv" -Append -Force -NoTypeInformation

Write-Host "Data has been successfully added."