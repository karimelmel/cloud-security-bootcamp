$BucketUrl = "https://hackcon-seceng-public.s3.amazonaws.com/mscb.zip"
$Archive = ".\mscb.zip"

If (!(Test-Path $Archive)) {
    Invoke-WebRequest -Uri $BucketUrl -OutFile mscb.zip }
If (!(Test-Path ".\mscb")) {
Expand-Archive -Path $Archive }
    .  .\mscb\mscb\Local_Script\BaselineLocalInstall.ps1 -WS2019NonDomainJoined -Verbose