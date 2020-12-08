Import-Module PsNLog -Force

$ScriptName = (Get-Item $PSCommandPath).Basename

# console target
$FileTarget = New-NLogTarget -TargetType 'FileTarget'
$FileTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'
$FileTarget.CreateDirs = $true	
$FileTarget.FileName = "$pwd/logs/$ScriptName/$ScriptName.$( (get-date).tostring('yyyyMMdd.HHmmss') ).log"

# configuration
$Config = New-NLogConfig
$Config.AddTarget("file", $FileTarget)

$FileRule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Warn) -Target $FileTarget
$Config.LoggingRules.Add($FileRule)

# Create a new Logger
$Log = New-NLogLogger -Name "Export-BambooHrEmployee" -Configuration $Config

# Write test Log messages
$Log.Debug("Debug Message")
$Log.Info("Info Message")
$Log.Warn("Warn Message")

$ex = [System.IO.FileNotFoundException]::new('the file wasn''t found')

$Log.Error($ex)
$Log.Trace("Trace Message")
$Log.Fatal("Fatal Message")
