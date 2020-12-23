<#
.SYNOPSIS
Creates a new logging target.

.DESCRIPTION
Creates a new logging target.

.PARAMETER TargetType

.EXAMPLE
$Target = New-NLogTarget -TargetType FileTarget

.LINK
https://nlog-project.org/documentation/v4.7.0/html/N_NLog_Targets.htm
#>
function New-NLogTarget() {

    [CmdletBinding()]
    [OutputType([NLog.Targets.Target])]
	param ( 
        [parameter(Mandatory)]
        [string]$TargetType
    )
    
    Write-Debug $MyInvocation.MyCommand.Name
    Write-Debug "TargetType: $TargetType"

	[System.Activator]::CreateInstance( [type]"NLog.Targets.$TargetType" )

}