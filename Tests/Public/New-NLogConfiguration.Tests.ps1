BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"
    $PrivatePath = Join-Path $ProjectDirectory "/PsNLog/Private/"

    # dependencies
    . (Join-Path $PrivatePath 'Register-Assembly.ps1')

    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    . (Join-Path $PublicPath $sut)
}

Describe "New-NLogConfiguration" {

    BeforeAll {
        Register-Assembly
    }

    Context "Parameter validation" {
    }

    Context "when no parameters are supplied" {

        BeforeEach {
            # act
            $Actual = New-NLogConfiguration
        }

        It "returns a [LoggingConfiguration]" {
            # assert
            $Actual | Should -BeOfType [NLog.Config.LoggingConfiguration]
        }

    } # /context

    Context 'when $Path is supplied' {

        BeforeEach {
            # arrange
            $Path = Join-Path $TestDrive "NLog.config"

            $Xml = "<?xml version='1.0' encoding='utf-8' ?>
            <nlog xmlns='http://www.nlog-project.org/schemas/NLog.xsd' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance'>
                <targets><target name='logconsole' xsi:type='ColoredConsole' layout='${message}'/></target>
                <rules><logger name='*' minlevel='Trace' writeTo='logconsole'/></rules>
            </nlog>"
            $Xml | Set-Content -Path $Path

            # act
            $Actual = New-NLogConfiguration -Path $Path
        }

        It "returns a [XmlLoggingConfiguration]" {
            # assert
            $Actual | Should -BeOfType [NLog.Config.XmlLoggingConfiguration]]
        }

    } # /context

}