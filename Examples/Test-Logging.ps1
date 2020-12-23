Import-Module PsNLog -Force

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
$Logger.Error( [System.IO.FileNotFoundException]::new('the file wasn''t found') )
$Logger.Fatal("Fatal Message")
