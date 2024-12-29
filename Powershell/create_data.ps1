
$data = @([PSCustomObject]@{ID = 1; Name = "John Doe"; Age = 30}
        [PSCustomObject]@{ID = 2; Name = "Jane Smith"; Age = 25}
        [PSCustomObject]@{ID = 3; Name = "Barco"; Age = 50}
        [PSCustomObject]@{ID = 4; Name = "Perry"; Age = 15}
        [PSCustomObject]@{ID = 5; Name = "Martha"; Age = 10; Gender = "Female"})


$path = "C:\Users\mahid\Downloads\demodata.csv"


$orderedData = $data | ForEach-Object {
    [PSCustomObject]@{
        ID = $_.ID
        Name = $_.Name
        Age = $_.Age
        Gender = $_.Gender 
    }
}

$orderedData | Export-Csv -Path $path -NoTypeInformation -Encoding UTF8


if (Test-Path -Path $path) {
    Write-Host "File is accessible"
    
   
    foreach ($e in $orderedData) {
        Write-Output $e
    }
} else {
    Write-Host "File is not accessible."
}