<#
.SYNOPSIS
Creates a new LoggingConfiguration object.

.DESCRIPTION
Creates a new LoggingConfiguration object.

.PARAMETER Path
Path of the XML configuration file.

.EXAMPLE
$Config = New-NLogConfiguration

Create a new, empty LoggingConfiguration based.

.EXAMPLE
$Config = New-NLogConfiguration -Path '/path/to/NLog.config'

Create a new LoggingConfiguration based on an XML-configuration file.

.LINK
https://nlog-project.org/documentation/v4.7.0/html/M_NLog_Config_LoggingConfiguration__ctor.htm

.LINK
https://nlog-project.org/documentation/v4.7.0/html/M_NLog_Config_XmlLoggingConfiguration__ctor_2.htm
#>
function New-NLogConfiguration() {

	[CmdletBinding()]
	[OutputType([NLog.Config.LoggingConfiguration])]
	param (
        [Parameter(Position=0, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateScript({(Test-Path $_) -and ((Get-Item $_).Extension -match '\.(config)')})]
        [Alias('FullName')]
        [string]$Path 
	)

	Begin { Write-Debug $MyInvocation.MyCommand.Name }

	Process {
		if ($Path) { [NLog.Config.XmlLoggingConfiguration]::New($Path, $true) }
		else { [NLog.Config.LoggingConfiguration]::new() }
	}

	End {}
}