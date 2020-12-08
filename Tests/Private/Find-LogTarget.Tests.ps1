BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PrivatePath = Join-Path $ProjectDirectory "/PsNLog/Private/"

    # Find-LogTarget.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Private/Find-LogTarget.ps1
    . (Join-Path $PrivatePath $sut)

}

Describe "Find-LogTarget" {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'Find-LogTarget'
        } 

        $Parameters = @(
            @{ParameterName='Pattern'; Type='[string]'; Mandatory=$false}
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

        Context "when Pattern isn't supplied" {
            BeforeEach {
                # act
                $Actual = Find-LogTarget
            }
    
            It "returns a [ConsoleTarget]" {
                # assert
                $Actual[0] | Should -BeOfType [NLog.Targets.Target]
            }    
        }

        Context "when Pattern isn't supplied" {
            BeforeEach {
                # act
                $Actual = Find-LogTarget -Pattern 'Co*'
            }
    
            It "returns a [ConsoleTarget]" {
                # assert
                $Actual[0] | Should -BeOfType [NLog.Targets.Target]
            }    
        }

    } # /context

}