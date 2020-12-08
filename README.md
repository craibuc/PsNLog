# PsNLog
PowerShell module that wraps the NLog assembly.

## Examples

```powershell
Import-Module PsNLog -Force

# console target
$ConsoleTarget = New-NLogTarget -TargetType 'ConsoleTarget'
$ConsoleTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

# configuration
$Config = New-NLogConfig
$Config.AddTarget("console", $ConsoleTarget)

# rule
$Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $ConsoleTarget
$Config.LoggingRules.Add($Rule)

# create log; assign configuration
$Log = New-NLogLogger -Name "ConsoleLog" -Configuration $Config

# write messages
$Log.Debug("Debug Message")
$Log.Info("Info Message")
$Log.Warn("Warn Message")

$ex = [System.IO.FileNotFoundException]::new('the file wasn''t found')
$Log.Error($ex)

$Log.Trace("Trace Message")
$Log.Fatal("Fatal Message")
```

## Reference

- [NLog](https://nlog-project.org/)
