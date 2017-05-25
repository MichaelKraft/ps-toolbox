$groups = Get-ADPrincipalGroupMembership $args[0]

write-host @"

Group Membership
----------------
"@

$groups| ForEach-Object { 
	write-host " - " $_.Name
}
write-host ""
