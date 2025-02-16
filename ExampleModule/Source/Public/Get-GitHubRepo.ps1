function Get-GitHubRepo {
    <#
    .SYNOPSIS
    Retrieves information about a GitHub repository.

    .DESCRIPTION
    This function uses the GitHub API to retrieve information about a specified repository.

    .PARAMETER repoOwner
    The GitHub username or organization name that owns the repository.

    .PARAMETER repoName
    The name of the GitHub repository.

    .PARAMETER token
    The GitHub token for authentication.

    .EXAMPLE
    Get-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster" -token (Get-Secret 'gist' -AsPlainText)

    .NOTES
    Author: Your Name
    #>
    [CmdletBinding()]
    param (
        [string]$repoOwner,
        [string]$repoName,
        [string]$token = (Get-Secret 'gist' -AsPlainText)
    )

    if (-not $token) {
        throw "GitHub token is required."
    }

    try {
        Write-Verbose "Retrieving information for repository $repoOwner/$repoName"
        $url = "https://api.github.com/repos/$repoOwner/$repoName"
        $headers = @{
            Authorization = "token $token"
            Accept        = "application/vnd.github.v3+json"
            "User-Agent"  = "PowerShell"
        }
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        return $response
    }
    catch {
        Write-Error "An error occurred while retrieving the repository: $_"
    }
}

# Example usage:
#$repoInfo = Get-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster" -Verbose
#$repoInfo | Format-List
