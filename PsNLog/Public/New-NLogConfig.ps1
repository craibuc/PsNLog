<#
.SYNOPSIS
Creates a new configuration in memory

.DESCRIPTION
Important to add logging behaviour and log targets to your LogManager

.EXAMPLE
$Config = New-NLogConfig

#>
function New-NLogConfig() {

	[CmdletBinding()]
	param ()

	[NLog.Config.LoggingConfiguration]::new()
}