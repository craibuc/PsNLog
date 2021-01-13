Import-Module PsNLog -Force

try {

    $ScriptName = (Get-Item $PSCommandPath).Basename
    $Here = Split-Path -Parent $MyInvocation.MyCommand.Path

    # configuration
    $Configuration = New-NLogConfiguration -Path "$Here/$ScriptName.NLog.config"
    $Configuration.Variables["ScriptDirectory"] = $Here

    # logger
    $Logger = New-NLogLogger -Configuration $Configuration

    # messages
    $Logger.Trace("Trace Message")
    $Logger.Debug("Debug Message")
    $Logger.Info("Info Message")
    # structured logging
    $Logger.Info("Created {typeName} #{primary_key_int}", 'INVOICE', 111);
    $Logger.Info("Created {typeName} #{primary_key_varchar}", 'BILL', 'ABC');
    # /structured logging
    $Logger.Warn("Warn Message")

    $Vendor = 'ABC'
    $Invoice = 111

    # throw [System.IO.FileNotFoundException]::new('the file wasn''t found')
    throw "invalid credentials"
}
catch [System.IO.FileNotFoundException] {
    $Message = "Vendor {vendor}/Invoice {invoice}", $Vendor, $Invoice
    $Logger.Error( $_.Exception , $Message)
}
catch {
    $Logger.Fatal( $_.Exception , "a fatal exception occurred")
}