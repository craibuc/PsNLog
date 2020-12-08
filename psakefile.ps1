# Include ./shared.psakefile.ps1

Properties {
    $ModuleName='PsNLog'
    $RepositoryName='Lorenz'
  }
  
FormatTaskName "-------- {0} --------"

Task default -depends List

Task List -description 'List all tasks' {
    psake -docs
}

Task Symlink -description "Create a symlink for '$ModuleName' module" {
    $Here = Get-Location
    Push-Location ~/.local/share/powershell/Modules
    ln -s "$Here/$ModuleName" $ModuleName
    Pop-Location
}
  
Task Publish -description "Publish module '$ModuleName' to repository '$RepositoryName'" {

    Publish-Module -name $ModuleName -Repository $RepositoryName

}
