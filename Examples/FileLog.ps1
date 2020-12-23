Import-Module PsNLog -Force

$ScriptName = (Get-Item $PSCommandPath).Basename
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

# console target
$FileTarget = New-NLogTarget -TargetType 'FileTarget'
$FileTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'
$FileTarget.CreateDirs = $true	
$FileTarget.FileName = "$Here/Logs/$ScriptName/$ScriptName.$( (Get-Date).ToString('yyyyMMdd') ).$( (Get-Date).ToString('HHmmss') ).log"

# configuration
$Config = New-NLogConfiguration
$Config.AddTarget("file", $FileTarget)

$FileRule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Warn) -Target $FileTarget
$Config.LoggingRules.Add($FileRule)

# Create a new Logger
$Logger = New-NLogLogger -Name $ScriptName -Configuration $Config

# Write test Log messages
$Logger.Debug("Debug Message")
$Logger.Info("Info Message")
$Logger.Warn("Warn Message")
$Logger.Error( [System.IO.FileNotFoundException]::new('the file wasn''t found') )
$Logger.Trace("Trace Message")
$Logger.Fatal("Fatal Message")
