<#
    Author: Karim El-Melhaoui
    Applies PowerShell Security baseline for NBIM Servers during provisioning.
    Use -Test parameter to audit systems towards the baseline.

    Details:
    - Enables transcripting to C:\Transcripts
    - Enables ScriptBlockLogging and Block invocation logging
    - Hardens PowerShell EventLog to avoid secrets being read by unprivileged users
    - Detects PowerShell v2 and removes if installed
#>

param(

    [Switch]$Test
)

#Enable PS transcript logging
$TranscriptRegPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription"
$Val1 = Get-ItemProperty -Path $TranscriptRegPath -Name EnableTranscripting -ErrorAction SilentlyContinue
if ($Test -and $val1.EnableTranscripting -eq 1) {
    Write-Host -ForegroundColor Yellow "PSTranscripting is already enabled. Value already exists.... "
}
elseif ($Test -and $val1.EnableTranscripting -notlike 1) {
    Write-Host -ForegroundColor Yellow "EnableTranscripting Registry key does not exist... Run command without '-Test' parameter to configure" 
}
else {
    Write-Host -ForegroundColor Green "Enabling PowerShell Transcripting and Including invocation header"
    New-Item -Path $TranscriptRegPath -Force
    Set-ItemProperty $TranscriptRegPath -Name EnableTranscripting -Value 1 -Force
    Set-ItemProperty $TranscriptRegPath -Name IncludeInvocationHeader -Value 1
}


#Ensure "C:\Transcripts" folder exists or create folder.
$TranscriptFolder = "C:\Transcripts"
$Val2 = Get-Item -Path $TranscriptFolder -ErrorAction SilentlyContinue
if ($Test -and $Val2.Exists) {
    Write-Host -ForegroundColor Yellow "C:\Transcripts folder already exists.... "
}
elseif ($Test -and $Val2.Exists -notlike $true) {
    Write-Host -ForegroundColor Yellow "C:\Transcripts folder does not exist... Run command without '-Test' parameter to configure" 
}
elseif ($val2.Exists ) {
    Write-Host -ForegroundColor Yellow "'C:\Transcripts' folder already exists... skipping"
}
else {
    Write-Host -ForegroundColor Green "Creating C:\Transcripts folder"
    mkdir $TranscriptFolder -ErrorAction SilentlyContinue
}

#Ensure Output directory is configured to "C:\Transcripts" or configure.
$Val3 = Get-ItemProperty -Path $TranscriptRegPath -Name OutputDirectory -ErrorAction SilentlyContinue
if ($Test -and $val3.OutputDirectory -eq "C:\Transcripts") {
    Write-Host -ForegroundColor Yellow "OutputDirectory value already exists and is configured.... skipping"
}
elseif ($Test -and $val3.OutputDirectory -notlike "C:\Transcripts") {
    Write-Host -ForegroundColor Yellow "OutputDirectory value does not exist... Run command without '-Test' parameter to configure" 
}
else {

    Write-Host -ForegroundColor Green "Configuring OutputDirectory to 'C:\Transcripts'"
    Set-ItemProperty $TranscriptRegPath -Name OutputDirectory -Value $TranscriptFolder
}


#Enables ScriptBlockLogging
$ScriptBlockRegPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
if (-not (Test-Path $ScriptBlockRegPath)) {
    $null = New-Item $ScriptBlockRegPath -Force
}
$Val4 = Get-ItemProperty -Path $ScriptBlockRegPath -Name EnableScriptBlockLogging -ErrorAction SilentlyContinue
if ($Test -and $Val4.EnableScriptBlockLogging -eq "1") {
    Write-Host -ForegroundColor Yellow "EnableScriptBlockLogging value already exists and is configured...."
} 
elseif ($Test -and $val4.EnableScriptBlockLogging -notlike "1") {
    Write-Host -ForegroundColor Yellow "Does not exist... Run command without '-Test' parameter to configure" 
}
else {
    Write-Host -ForegroundColor Green "Configuring ScriptBlockLogging.... "
    New-Item -Path $ScriptBlockRegPath -Force
    Set-ItemProperty $ScriptBlockRegPath -Name EnableScriptBlockLogging -Value 1
}


#Enables Script Block Invocation logging
$ScriptBlockInvocationRegPath = "HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$Val5 = Get-ItemProperty -Path $ScriptBlockInvocationRegPath -Name EnableScriptBlockInvocationLogging -ErrorAction SilentlyContinue
if ($Test -and $Val5.EnableScriptBlockInvocationLogging -eq "1") {
    Write-Host -ForegroundColor Yellow "EnableScriptBlockInvocationLogging value already exists and is configured...."
} 
elseif ($Test -and $val5.EnableScriptBlockInvocationLogging -notlike "1") {
    Write-Host -ForegroundColor Yellow "EnableScriptBlockInvocationLogging value does not exist... Run command without '-Test' parameter to configure" 
}
else {
    Write-Host -ForegroundColor Green "Configuring ScriptBlockInvocationLogging.... "
    Set-ItemProperty $ScriptBlockInvocationRegPath -Name EnableScriptBlockInvocationLogging -Value 1
}


#Prevents users from reading PowerShell logs which may contain secrets
$PSSecurityRegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-PowerShell/Operational"
if ($test -eq $false) { 
    Write-Host -ForegroundColor Green "Hardening PowerShell Event Log to prevent users from reading..."
    Set-ItemProperty $PSSecurityRegPath -Name ChannelAccess -Value "O:BAG:SYD:(A;;0xf0005;;;SY)(A;;0x5;;;BA)(A;;0x1;;;S-1-5-32-573)(A;;0x1;;;NS)" 
} 


#Confirms PowerShell v2 is not installed. Removes if installed.
$InstallState = Get-WindowsFeature PowerShell-V2
if ($Test -and $InstallState.InstallState -notlike "Installed" -or "Available") {
    Write-Host -ForegroundColor Green "PowerShell v2 is not installed..."
}
elseif ($Test -and $InstallState.InstallState -eq "Installed" -or "Available") {
    Write-Host -ForegroundColor Red "PowerShell v2 is installed... Must be removed to enforce security measures applied. Run command with out -Test to remove."
}
else {
    Write-Host -ForegroundColor Green "Removing PowerShell version 2...."
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2
}

#Ensures Constrained Language mode is enforced and remediates when not enforced.
$FullLanguage = "FullLanguage"
if ($test -and $ExecutionContext.SessionState.LanguageMode -eq $FullLanguage)
{
 Write-Host -ForegroundColor Yellow "Full Language Mode is enabled. This indicates system is not properly configured with AppLocker"  
}
elseif ($test -eq $true -and $ExecutionContext.SessionState.LanguageMode -eq $FullLanguage) {
    Write-Host -ForegroundColor Green "Constrained Language Mode is Enforced"
} 
else {
    Write-Host -ForegroundColor Green "Enforcing Constrained Language Mode"
    $ExecutionContext.SessionState.LanguageMode = "ConstrainedLanguage"
}
