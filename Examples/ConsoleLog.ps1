
Import-Module PsNLog -Force

# console target
$ConsoleTarget = New-NLogTarget -TargetType 'ConsoleTarget'
# https://nlog-project.org/config/?tab=layout-renderers
$ConsoleTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

# configuration
$Config = New-NLogConfig
$Config.AddTarget("console", $ConsoleTarget)

$Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $ConsoleTarget
$Config.LoggingRules.Add($Rule)

# Create a new Logger
$Log = New-NLogLogger -Name "ConsoleLog" -Configuration $Config

# Write test Log messages
$Log.Debug("Debug Message")
$Log.Info("Info Message")
$Log.Warn("Warn Message")

$ex = [System.IO.FileNotFoundException]::new('the file wasn''t found')

$Log.Error($ex)
$Log.Trace("Trace Message")
$Log.Fatal("Fatal Message")
