Import-Module PsNLog -Force

# console target
$ConsoleTarget = New-NLogTarget -TargetType 'ColoredConsoleTarget'
# https://nlog-project.org/config/?tab=layout-renderers
$ConsoleTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

# configuration
$Config = New-NLogConfiguration
$Config.AddTarget("console", $ConsoleTarget)

$Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $ConsoleTarget
$Config.LoggingRules.Add($Rule)

# Create a new Logger
$Logger = New-NLogLogger -Configuration $Config

# Write test Log messages
$Logger.Trace("Trace Message")
$Logger.Debug("Debug Message")
$Logger.Info("Info Message")
$Logger.Warn("Warn Message")
$Logger.Error( [System.IO.FileNotFoundException]::new('the file wasn''t found') )
$Logger.Fatal("Fatal Message")
