#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*), and disabled scripts (__*)
#

@("$PSScriptRoot\Public\*.ps1","$PSScriptRoot\Private\*.ps1") | Get-ChildItem -ErrorAction 'Continue' | 
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } | 
    ForEach-Object {
        # dot-source script
        . $_
    }


Get-ChildItem "$PSScriptRoot\lib" -Filter *.dll | ForEach-Object {
    Write-Verbose "Loading $( $_.Name )"
    [System.Reflection.Assembly]::LoadFile( $_.FullName )
}
