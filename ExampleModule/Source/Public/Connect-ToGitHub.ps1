function Connect-ToGitHub {
    <#
    .SYNOPSIS
    Connects to GitHub by retrieving or prompting for a GitHub token.

    .DESCRIPTION
    This function retrieves a GitHub token from the secret store. If the token is not found, it prompts the user to enter the token and saves it to the secret store for future use.

    .EXAMPLE
    Connect-ToGitHub

    Connects to GitHub by retrieving the token from the secret store or prompting the user to enter it.

    .NOTES
    Author: Your Name
    #>
    try {
        $script:token = Get-Secret 'gist' -AsPlainText
    }
    catch {
        $script:token = Read-Host "Please enter your GitHub token"
        try {
            Set-Secret -Name 'gist' -Secret $global:token
        }
        catch {
            Write-Host "Error saving the token to the secret store. Ensure SecretManagement module is installed and configured."
            return
        }
    }

    $script:headers = @{
        Authorization  = "token $global:token"
        "Content-Type" = "application/json"
    }
}