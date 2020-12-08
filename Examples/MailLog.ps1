Import-Module PsNLog -Force

# email target
$MailTarget = New-NLogTarget -TargetType 'MailTarget'
$MailTarget.Layout = '${logger}|${date:format=yyyy-MM-dd HH\:mm\:ss}|${level:uppercase=true}|${message}'

$MailTarget.SmtpServer	    = "smtp.office365.com"
$MailTarget.SmtpPort		= "587"
$MailTarget.EnableSsl		= $true
$MailTarget.smtpUserName	= ""
$MailTarget.smtpPassword	= ""
$MailTarget.From			= ""
$MailTarget.To			    = ""
$MailTarget.Encoding 		= [System.Text.Encoding]::GetEncoding("iso-8859-2")
$MailTarget.Subject		    = "[NLog] MailLogger Test"

# configuration
$Config = New-NLogConfig
$Config.AddTarget("mail", $MailTarget)

$Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $MailTarget
$Config.LoggingRules.Add($Rule)

# Create a new Logger
$Log = New-NLogLogger -Name 'MailLog' -Configuration $Config

# Write test Log messages
$Log.Debug("Debug Message") # sends the message
# $Log.Info("Info Message")
# $Log.Warn("Warn Message")
# $Log.Error("Error Message")
# $Log.Trace("Trace Message")
# $Log.Fatal("Fatal Message")
