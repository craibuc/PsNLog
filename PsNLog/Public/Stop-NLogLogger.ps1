function Stop-NLogLogger {

    [CmdletBinding()]
    param ()

    [NLog.LogManager]::Shutdown()
}