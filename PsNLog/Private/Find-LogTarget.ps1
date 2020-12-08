function Find-LogTarget {

    param (
        [string]$Pattern = '*'
    )
    
    $Parent = Split-Path $PSScriptRoot -Parent

    [System.Reflection.Assembly]::LoadFile( "$Parent\lib\NLog.dll" ) |
    Select-Object -Expand ExportedTypes | 
    Where-Object { $_.Namespace -eq 'NLog.Targets' -and $_.Name -like $Pattern -and ( [type]$_.FullName ).IsSubclassOf( [NLog.Targets.Target] ) -eq $true }

}
