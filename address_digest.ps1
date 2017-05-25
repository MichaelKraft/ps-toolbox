$identity = $args[0]

write-host @"

Account email addressses
------------------------
"@

Get-Mailbox -Identity "$identity" | select -expand emailaddresses | foreach { 
	write-host $_.AddressString 
}

write-host @"

Account Group Membership Addresses
----------------------------------
"@

$groups = Get-ADPrincipalGroupMembership $identity | foreach {
	if(((Get-DistributionGroup $_.Name -ErrorAction 'SilentlyContinue').IsValid) -eq $true) {
		$email = Get-DistributionGroup -Identity $_.Name | foreach { $_.PrimarySmtpAddress }
		write-host "$email"
	}
}

write-host @"

Accounts Forwarded to Account
-----------------------------
"@

$RecipientCN = (get-recipient $identity).Identity
get-mailbox | Where-Object { $_.ForwardingAddress -eq $RecipientCN } | select -expand emailaddresses | foreach {
	$_.AddressString
}

write-host ""
