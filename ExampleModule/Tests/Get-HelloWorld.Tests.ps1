Describe 'Get-HelloWorld Function Tests' {
    It 'Should return Hello, World! by default' {
        Get-HelloWorld | Should -Be 'Hello, World!'
    }

    It 'Should return Hello, John! when Name is John' {
        Get-HelloWorld -Name 'John' | Should -Be 'Hello, John!'
    }
}
