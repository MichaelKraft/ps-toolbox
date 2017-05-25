Import-Module ActiveDirectory
if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction SilentlyContinue) -eq $null ) {
	add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
}

$search = $args[0]
$found = 0

if(-Not ($search -match '@')) {
	write-host "Invalid email specified"
	exit
}

Get-DistributionGroup | foreach { 
	$emails = $_.EmailAddresses
	foreach($email in $emails) {
		if( $email -eq $search ) {
			write-host ""
			write-host "Found in Distribution Group:"
			Get-DistributionGroup -Identity $_
			write-host ""
			write-host "Which is delivered to:"
			Get-DistributionGroupMember -Identity $_.Name | foreach {
				write-host " - " $_.Name
				write-host "   " $_.PrimarySMTPAddress
			}
			$found = 1
		}
	}
}

Get-Mailbox | foreach { 
	$emails = $_.EmailAddresses
	foreach($email in $emails) {
		if( $email -eq $search ) {
			write-host ""
			write-host "Found in User Mailbox:"
			Get-Mailbox -Identity $_
			write-host ""
			$found = 1
		}
	}
}

if($found -eq 0) {
	write-host ""
	write-host "No results found"
	write-host ""
}
