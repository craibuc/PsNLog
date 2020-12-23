<#
.SYNOPSIS
Creates a new LogManager rule

.DESCRIPTION
Creates a new LogManager rule


.PARAMETER Pattern

.PARAMETER LogLevel

.PARAMETER Target

.EXAMPLE
$Target = New-NLogTarget -TargetType 'file'

$Rule = New-NLogRule -Pattern '*' -LogLevel Trace -Target $Target

.LINK
https://nlog-project.org/documentation/v4.7.0/html/T_NLog_Config_LoggingRule.htm
#>
function New-NLogRule {

    [CmdletBinding()]
    [OutputType([NLog.Config.LoggingRule])]
    param ( 
        [Parameter(Mandatory)] 
        [string]$Pattern,

        [Parameter(Mandatory)]
        [ValidateSet('Debug','Trace','Info','Warn','Error','Fatal','Off')]
        [string]$LogLevel,

        [Parameter(Mandatory)]
        [NLog.Targets.Target]$Target
    ) 
    
    Write-Debug $MyInvocation.MyCommand.Name
    Write-Debug "Pattern: $Pattern"
    Write-Debug "LogLevel: $LogLevel"
    Write-Debug "Target: $Target"

    [NLog.Config.LoggingRule]::new($Pattern, [NLog.LogLevel]::FromString($LogLevel), $Target)

}
