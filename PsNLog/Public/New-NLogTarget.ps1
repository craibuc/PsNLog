<#
.SYNOPSIS
Creates a new logging target

.DESCRIPTION
Logging targets are required to write down the log messages somewhere

.PARAMETER TargetType

.EXAMPLE
$FileLogTarget = New-NLogTarget -TargetType 'file'

.LINK
https://nlog-project.org/documentation/v3.2.1/html/N_NLog_Targets.htm
#>
function New-NLogTarget() {

	[CmdletBinding()]
	param ( 
        [parameter(Mandatory)]
        [ValidateSet('ColoredConsoleTarget','ConsoleTarget','FileTarget','MailTarget')]
        [string]$TargetType 
    )
	
	[System.Activator]::CreateInstance( [type]"NLog.Targets.$TargetType" )

    # switch ($TargetType) {
	# 	"ConsoleTarget" {
	# 		[NLog.Targets.ConsoleTarget]::new()
	# 	}
	# 	"FileTarget" {
	# 		[NLog.Targets.FileTarget]::new()
	# 	}
	# 	"MailTarget" { 
	# 		[NLog.Targets.MailTarget]::new()
	# 	}
	# }

}