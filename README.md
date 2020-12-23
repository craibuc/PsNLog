# PsNLog
PowerShell module that wraps the NLog assembly.

## Examples

### ConsoleTarget

```powershell
Import-Module PsNLog

# console target
$ConsoleTarget = New-NLogTarget -TargetType 'ConsoleTarget'
$ConsoleTarget.Layout = '${machinename}|${environment-user}|${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

# configuration
$Config = New-NLogConfiguration
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
$Log.Error( [System.IO.FileNotFoundException]::new('the file wasn''t found') )
$Log.Trace("Trace Message")
$Log.Fatal("Fatal Message")
```

### DatabaseTarget

### FileTarget

```powershell
Import-Module PsNLog

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
```

### MailTarget

```powershell
Import-Module PsNLog

# email target
$MailTarget = New-NLogTarget -TargetType 'MailTarget'
$MailTarget.Layout = '${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

$MailTarget.SmtpServer	    = 'smtp.domain.tld'
$MailTarget.SmtpPort		= "587"
$MailTarget.EnableSsl		= $true
$MailTarget.smtpUserName	= 'USERNAME'
$MailTarget.smtpPassword	= 'PASSWORD'
$MailTarget.From			= 'FROM'
$MailTarget.To			    = 'TO'
$MailTarget.Encoding 		= [System.Text.Encoding]::GetEncoding("iso-8859-2")
$MailTarget.Subject		    = "[NLog] MailLogger Test"

# configuration
$Config = New-NLogConfiguration
$Config.AddTarget("mail", $MailTarget)

$Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $MailTarget
$Config.LoggingRules.Add($Rule)

# Create a new Logger
$Logger = New-NLogLogger -Name 'MailLog' -Configuration $Config

# Write test Log messages (one mail message each)
$Logger.Debug("Debug Message") # sends the message
$Logger.Info("Info Message")
$Logger.Warn("Warn Message")
$Logger.Error( [System.IO.FileNotFoundException]::new('the file wasn''t found') )
$Logger.Trace("Trace Message")
$Logger.Fatal("Fatal Message")
```

## Reference

- [NLog](https://nlog-project.org/)
