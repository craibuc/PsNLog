BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"

    # New-NLogRule.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Public/New-NLogRule.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-NLogRule" {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'New-NLogRule'
        } 

        $Parameters = @(
            @{ParameterName='Pattern'; Type='[string]'; Mandatory=$true}
            @{ParameterName='LogLevel'; Type='[string]'; Mandatory=$true}
            @{ParameterName='Target'; Type='[NLog.Targets.Target]'; Mandatory=$true}
        )

        Context 'Data type' {
        
            It "<ParameterName> is a <Type>" -TestCases $Parameters {
                param ($ParameterName, $Type)
                $Command | Should -HaveParameter $ParameterName -Type $Type
            }

        }

        Context "Mandatory" {
            it "<ParameterName> Mandatory is <Mandatory>" -TestCases $Parameters {
                param($ParameterName, $Mandatory)
                
                if ($Mandatory) { $Command | Should -HaveParameter $ParameterName -Mandatory }
                else { $Command | Should -HaveParameter $ParameterName -Not -Mandatory }
            }    
        }
    
    } # /Context

    Context "Usage" {

        BeforeEach {
            # arrange
            $Pattern = '*'
            $LogLevel = 'Debug' # [NLog.LogLevel]::Debug
            $Target = [NLog.Targets.ColoredConsoleTarget]::new()

            # act
            $Actual = New-NLogRule -Pattern $Pattern -LogLevel $LogLevel -Target $Target
        }

        It "returns a [LoggingRule]" {
            # assert
            $Actual | Should -BeOfType [NLog.Config.LoggingRule]
        }

    } # /context

}