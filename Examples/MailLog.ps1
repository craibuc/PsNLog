Import-Module PsNLog -Force

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
$Logger.Error("Error Message")
$Logger.Trace("Trace Message")
$Logger.Fatal("Fatal Message")
