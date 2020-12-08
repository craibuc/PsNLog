<#
.SYNOPSIS
Creates a new LogManager instance

.DESCRIPTION
Important to log messages to file, mail, console etc.

.PARAMETER Name

.PARAMETER Configuration

.EXAMPLE
$Logger = New-NLogLogger -Name 'lorem ipsum'

#>
function New-NLogLogger() {

    [CmdletBinding()]
    param ( 
        [parameter(Mandatory)] 
        [string]$Name,

        [parameter(Mandatory)] 
        [object]$Configuration
    ) 
    
    [NLog.LogManager]::GetLogger($Name)
    [NLog.LogManager]::Configuration = $Configuration
}
