BeforeAll {

    # /PsNLog
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent

    # /PsNLog/PsNLog/Public
    $PublicPath = Join-Path $ProjectDirectory "/PsNLog/Public/"

    # New-NLogLogger.ps1
    $sut = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    # . /PsNLog/PsNLog/Public/New-NLogLogger.ps1
    . (Join-Path $PublicPath $sut)

}

Describe "New-NLogLogger" {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'New-NLogLogger'
        } 

        $Parameters = @(
            @{ParameterName='Name'; Type='[string]'; Mandatory=$true}
            @{ParameterName='Configuration'; Type='[object]'; Mandatory=$true}
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
            $Name = 'lorem ipsum'
            $Config = [NLog.Config.LoggingConfiguration]::new()

            # act
            $Actual = New-NLogLogger -Name $Name -Configuration $Config
        }

        It "returns a [Logger]" {
            # assert
            $Actual | Should -BeOfType [NLog.Logger]
        }

        It "with a name" {
            # assert
            $Actual.Name | Should -Be $Name
        }

    } # /context

}