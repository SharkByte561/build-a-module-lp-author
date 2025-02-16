function New-GitHubRepo {
    <#
    .SYNOPSIS
    Creates a new GitHub repository.

    .DESCRIPTION
    This function uses the GitHub API to create a new repository under the authenticated user's account.

    .PARAMETER repoName
    The name of the new GitHub repository.

    .PARAMETER token
    The GitHub token for authentication.

    .PARAMETER description
    A description of the new repository.

    .PARAMETER private
    Indicates whether the repository should be private. Defaults to $false.

    .EXAMPLE
    New-GitHubRepo -repoName "NewRepo" -token (Get-Secret 'gist' -AsPlainText) -description "This is a new repository" -private

    .NOTES
    Author: Your Name
    #>
    [CmdletBinding()]
    param (
        [string]$repoName,
        [string]$token = (Get-Secret 'gist' -AsPlainText),
        [string]$description = "",
        [bool]$private = $false
    )

    if (-not $token) {
        throw "GitHub token is required."
    }

    try {
        Write-Verbose "Creating new repository $repoName"
        $url = "https://api.github.com/user/repos"
        $headers = @{
            Authorization = "token $token"
            Accept        = "application/vnd.github.v3+json"
            "User-Agent"  = "PowerShell"
        }
        $body = @{
            name        = $repoName
            description = $description
            private     = $private
        } | ConvertTo-Json
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $body
        return $response
    }
    catch {
        Write-Error "An error occurred while creating the repository: $_"
    }
}

# Example usage:
#New-GitHubRepo -repoName "NewRepo" -description "This is a new repository" -private:$true -Verbose
