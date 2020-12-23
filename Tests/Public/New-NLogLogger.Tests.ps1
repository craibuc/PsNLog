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
            @{ParameterName='Name'; Type='[string]'; Mandatory=$false}
            @{ParameterName='Configuration'; Type='[object]'; Mandatory=$false}
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

        Context "When Name and Configuration supplied" {
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
        }

        Context "When Name isn't supplied" {
            BeforeEach {
                # arrange
                $Config = [NLog.Config.LoggingConfiguration]::new()
    
                # act
                $Actual = New-NLogLogger -Configuration $Config
            }
    
            It "returns a [Logger]" {
                # assert
                $Actual | Should -BeOfType [NLog.Logger]
            }
    
            It "with a name that matches the name of the calling script" {
                # assert
                $Actual.Name | Should -Be '<ScriptBlock>'
            }    
        }

    } # /context

}