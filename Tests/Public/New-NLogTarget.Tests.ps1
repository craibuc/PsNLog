BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"

    # New-NLogTarget.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Public/New-NLogTarget.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-NLogTarget" {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'New-NLogTarget'
        } 

        $Parameters = @(
            @{ParameterName='TargetType'; Type='[string]'; Mandatory=$true}
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

        Context "ConsoleTarget" {
            BeforeEach {
                # 
                $TargetType = 'ConsoleTarget'

                # act
                $Actual = New-NLogTarget -TargetType $TargetType
            }

            It "returns a [ConsoleTarget]" {
                # assert
                $Actual | Should -BeOfType [NLog.Targets.ConsoleTarget]
            }
        }

        Context "FileTarget" {
            BeforeEach {
                # act
                $Actual = New-NLogTarget -TargetType 'FileTarget'
            }

            It "returns a [FileTarget]" {
                # assert
                $Actual | Should -BeOfType [NLog.Targets.FileTarget]
            }
        }

        Context "MailTarget" {
            BeforeEach {
                # act
                $Actual = New-NLogTarget -TargetType 'MailTarget'
            }

            It "returns a [MailTarget]" {
                # assert
                $Actual | Should -BeOfType [NLog.Targets.MailTarget]
            }
        }

    } # /context

}