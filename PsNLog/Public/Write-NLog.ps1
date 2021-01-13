<#

#>
function Write-NLog {

    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [string]$LoggerName = (Get-PSCallStack)[1].Command,

        [Parameter(Position=1,Mandatory,ValueFromPipeline)]
        [string]$Message,

        [Parameter(Mandatory)]
        [ValidateSet('Debug','Trace','Info','Warn','Error','Fatal','Off')]
        [string]$LogLevel
    )

    Write-Debug $MyInvocation.MyCommand.Name
    Write-Debug "LoggerName: $LoggerName"
    Write-Debug "Message: $Message"
    Write-Debug "LogLevel: $LogLevel"

    $LoggerName = [string]::IsNullOrEmpty($LoggerName) ? (Get-PSCallStack)[1].Command : $LoggerName

    $Logger = [NLog.LogManager]::GetLogger($LoggerName)

    switch ($LogLevel) {
        Trace { $Logger.Trace($Message) }
        Debug { $Logger.Debug($Message) }
        Info { $Logger.Info($Message) }
        Warn { $Logger.Warn($Message) }
        Error { $Logger.Error($Message) }
        Fatal { $Logger.Fatal($Message) }
    }

}