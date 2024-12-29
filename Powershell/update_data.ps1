$data = import-csv -path "C:\Users\mahid\Downloads\demodata.csv"

foreach($row in $data){
if($row.Name -eq "John Doe"){
$row.Age = 30
write-host "Age has been successfully changed"
}
}



$data | export-csv -path "C:\Users\mahid\Downloads\demodata.csv" -Encoding UTF8