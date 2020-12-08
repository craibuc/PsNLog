BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"

    # New-NLogConfig.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Public/New-NLogConfig.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-NLogConfig" {

    Context "Usage" {

        BeforeEach {
            # act
            $Actual = New-NLogConfig
        }

        It "returns a [ConsoleTarget]" {
            # assert
            $Actual | Should -BeOfType [NLog.Config.LoggingConfiguration]
        }

    } # /context

}