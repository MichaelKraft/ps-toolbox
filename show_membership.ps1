Import-Module ActiveDirectory
if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction SilentlyContinue) -eq $null ) {
	add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
}

$groups = Get-ADPrincipalGroupMembership $args[0]

write-host @"

Group Membership
----------------
"@

$groups| ForEach-Object { 
	write-host " - " $_.Name
}
write-host ""
