function Register-Assembly {

    [CmdletBinding()]
    param ()

    $ModuleDirectory = Split-Path $PSScriptRoot -Parent

    Get-ChildItem "$ModuleDirectory" -Filter *.dll | ForEach-Object {
        Write-Verbose "Loading $( $_.Name )"
        [System.Reflection.Assembly]::LoadFile( $_.FullName )
    }
    
}