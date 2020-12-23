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
    [OutputType([NLog.Logger])]
    param ( 
        [Parameter(Position=0)]
        [string]$Name = (Get-PSCallStack)[1].Command,

        [Parameter(Position=1)]
        [NLog.Config.LoggingConfiguration]$Configuration
    ) 

    Write-Debug $MyInvocation.MyCommand.Name
    Write-Debug "Name: $Name"
    Write-Debug "Configuration: $Configuration"

    $Name = [string]::IsNullOrEmpty($Name) ? (Get-PSCallStack)[1].Command : $Name

    [NLog.LogManager]::GetLogger($Name)
    if ($Configuration)
    {
        [NLog.LogManager]::Configuration = $Configuration
    }

}
