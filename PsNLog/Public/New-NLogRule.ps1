<#
.SYNOPSIS
Creates a new LogManager rule

.DESCRIPTION
Creates a new LogManager rule


.PARAMETER Pattern

.PARAMETER LogLevel

.PARAMETER Target

.EXAMPLE
$Logger = New-NLogRule -Pattern '*'

#>
function New-NLogRule {

    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory)] 
        [string]$Pattern,

        [Parameter(Mandatory)]
        [ValidateSet('Debug','Trace','Info','Warn','Error','Fatal','Off')]
        [string]$LogLevel,

        [Parameter(Mandatory)]
        [NLog.Targets.Target]$Target
    ) 
    
    [NLog.Config.LoggingRule]::new($Pattern, [NLog.LogLevel]::FromString($LogLevel), $Target)

}
