function Write-Warning {

    [CmdletBinding()]
    param (
        [string]$Message
    )

    [NLog.Logger].Warn($Message)

}