$blockPrincipal = New-Object -TypeName System.Security.Principal.NTAccount ("Everyone")
$BlockPrincipalSID = $blockPrincipal.Translate([System.Security.Principal.SecurityIdentifier]).Value
$exceptionPrincipal = New-Object -TypeName System.Security.Principal.NTAccount ("Administrators")
$ExceptionPrincipalSID = $exceptionPrincipal.Translate([System.Security.Principal.SecurityIdentifier]).Value
$PrincipalSDDL = "O:LSD:(D;;CC;;;$ExceptionPrincipalSID)(A;;CC;;;$BlockPrincipalSID)"

New-NetFirewallRule -DisplayName "Block metatdata service for $($blockPrincipal.Value), exception: $($exceptionPrincipal.Value)" `
    -Action Block `
    -Direction Outbound `
    -Protocol TCP `
    -RemoteAddress 169.254.169.254 `
    -LocalUser $PrincipalSDDL