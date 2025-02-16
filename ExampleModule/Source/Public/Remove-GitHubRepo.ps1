function Remove-GitHubRepo {
    <#
    .SYNOPSIS
    Deletes a GitHub repository.

    .DESCRIPTION
    This function uses the GitHub API to delete a specified repository. It requires the repository owner, repository name, and a GitHub token with the necessary permissions.

    .PARAMETER repoOwner
    The GitHub username or organization name that owns the repository.

    .PARAMETER repoName
    The name of the GitHub repository.

    .PARAMETER token
    The GitHub token for authentication. This token must have the necessary permissions to delete the repository.

    .EXAMPLE
    Remove-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster" -token (Get-Secret 'gist' -AsPlainText)

    Deletes the repository "SnippetMaster" owned by "SharkByte561".

    .NOTES
    Author: Your Name
    #>
    param (
        [string]$repoOwner,
        [string]$repoName,
        [string]$token = (Get-Secret 'gist' -AsPlainText)
    )

    if (-not $token) {
        throw "GitHub token is required."
    }

    try {
        Write-Verbose "Deleting repository $repoOwner/$repoName"
        $url = "https://api.github.com/repos/$repoOwner/$repoName"
        $headers = @{
            Authorization          = "Bearer $token"
            Accept                 = "application/vnd.github+json"
            "User-Agent"           = "PowerShell"
            "X-GitHub-Api-Version" = "2022-11-28"
        }
        Invoke-RestMethod -Uri $url -Headers $headers -Method Delete -ErrorAction Stop
        Write-Host "Repository $repoOwner/$repoName deleted successfully."
    }
    catch {
        Write-Error "An error occurred while deleting the repository: $_"
    }
}

# Example usage:
#Remove-GitHubRepo -repoOwner "SharkByte561" -repoName "NewRepoName" -Verbose
