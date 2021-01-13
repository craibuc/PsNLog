BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"
    $PrivatePath = Join-Path $ProjectDirectory "/PsNLog/Private/"

    # dependencies
    . (Join-Path $PrivatePath 'Register-Assembly.ps1')

    # Write-NLog.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Public/Write-NLog.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "Write-NLog" {

    Context "Usage" {

        BeforeEach {
            # arrange
            Register-Assembly

            $ConsoleTarget = New-NLogTarget -TargetType 'ConsoleTarget'
            $Config = New-NLogConfig
            $Config.AddTarget("console", $ConsoleTarget)
            $Rule = New-NLogRule -Pattern '*' -LogLevel ([NLog.LogLevel]::Trace) -Target $ConsoleTarget
            $Config.LoggingRules.Add($Rule)

            $Logger = New-NLogLogger -Name "ConsoleLog" -Configuration $Config

            # act
            # $Log.Info("Info Message")
            $Actual = Write-NLog -LoggerName 'ConsoleLog' -Message "lorem ipsum" -LogLevel Info
        }

        It "does something usegul" {
            # assert
            $false | Should -Be $true
        }

    } # /context

}