Import-Module ActiveDirectory
if ( (Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.E2010 -ErrorAction SilentlyContinue) -eq $null ) {
	add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
}

$identity = $args[0]

if(((Get-DistributionGroup -Identity $identity -ErrorAction 'SilentlyContinue').IsValid) -eq $true) {
	$output = @"

Email Addresses for $identity
----------------------------------------

"@
	Get-DistributionGroup -Identity $identity | foreach { 
		$emails = $_.EmailAddresses
		foreach($email in $emails) {
			if( $email -match "smtp:" ) {
				$email = $email -replace "smtp:"
			}
			$output += " - $email`n"
		}
	}
	write-host $output
	write-host "Membership:"
	Get-DistributionGroupMember -Identity $identity | foreach {
		write-host " - " $_.Name
		write-host "   " $_.PrimarySMTPAddress
	}
	write-host ""
} else {
	write-host "`nGroup with Identity ""$identity"" could not be found.`n"
}
