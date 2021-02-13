$BucketUrl = "https://hackcon-seceng-public.s3.amazonaws.com"
$File = "/winpmem_mini_x64_rc2.exe"
$MemoryDump = "physmem.raw"

If (!(Test-Path $File)) {
    Invoke-WebRequest -Uri $BucketUrl$File -OutFile winpmem_mini_x64_rc2.exe }

If (!(Test-Path $MemoryDump)) {
    .\winpmem_mini_x64_rc2.exe $MemoryDump }

$ForensicsBucket = Get-CFNExport | Where-Object {$_.Name -contains "ForensicsBucket" } | Select-Object Value

try {
    Write-Output "Copying snapshot to foresncis bucket: $ForensicsBucket.. "
    Write-S3Object -BucketName $ForensicsBucket.Value -File .\physmem.raw -Key physmem.raw
    Write-Output "Snapshot successfully copied to forensics bucket."
}
catch {
    Write-Output "Upload failed.."
}