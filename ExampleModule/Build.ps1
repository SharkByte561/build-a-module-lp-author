param (
    [version]$Version = '1.0.1',
    [switch]$RunTests
)

#Requires -Module ModuleBuilder

# Build parameters
$params = @{
    SourcePath                = "X:\Vault\GithubRepos\_SharkByte561\build-a-module-lp-author\ExampleModule\Source\ExampleModule.psd1"
    CopyPaths                 = @("X:\Vault\GithubRepos\_SharkByte561\build-a-module-lp-author\ExampleModule\README.md")
    Version                   = $Version
    UnversionedOutputDirectory = $true
}

# Build the module
Build-Module @params

# Run Pester tests if -RunTests is specified
if ($RunTests) {
    Write-Host 'Running Pester tests...'
    Invoke-Pester -Path "X:\Vault\GithubRepos\_SharkByte561\build-a-module-lp-author\ExampleModule\Tests" -Output Detailed
}
