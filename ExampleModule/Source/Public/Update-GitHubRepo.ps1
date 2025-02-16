function Update-GitHubRepo {
    <#
    .SYNOPSIS
    Updates a GitHub repository.

    .DESCRIPTION
    This function uses the GitHub API to update a specified repository's details. It first verifies if the repository exists and then updates its details based on the provided parameters.

    .PARAMETER repoOwner
    The GitHub username or organization name that owns the repository.

    .PARAMETER repoName
    The name of the GitHub repository.

    .PARAMETER token
    The GitHub token for authentication. This token must have the necessary permissions to update the repository.

    .PARAMETER newName
    The new name for the repository.

    .PARAMETER description
    A description of the repository.

    .PARAMETER homepage
    The URL of the repository's homepage.

    .PARAMETER private
    Indicates whether the repository should be private. Default is $true.

    .PARAMETER hasIssues
    Indicates whether the repository should have issues enabled. Default is $true.

    .PARAMETER hasProjects
    Indicates whether the repository should have projects enabled. Default is $true.

    .PARAMETER hasWiki
    Indicates whether the repository should have a wiki enabled. Default is $true.

    .EXAMPLE
    Update-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster" -token (Get-Secret 'gist' -AsPlainText) -newName "NewRepoName" -description "Updated description" -homepage "https://github.com" -private -hasIssues -hasProjects -hasWiki

    Updates the repository "SnippetMaster" owned by "SharkByte561" with the new name "NewRepoName", updated description, homepage URL, and other settings.

    .NOTES
    Author: Your Name
    #>
    [CmdletBinding()]
    param (
        [string]$repoOwner,
        [string]$repoName,
        [string]$token = (Get-Secret 'gist' -AsPlainText),
        [string]$newName,
        [string]$description,
        [string]$homepage,
        [bool]$private = $true,
        [bool]$hasIssues = $true,
        [bool]$hasProjects = $true,
        [bool]$hasWiki = $true
    )

    if (-not $token) {
        throw "GitHub token is required."
    }

    try {
        # Verify if the repository exists
        Get-GitHubRepo -repoOwner $repoOwner -repoName $repoName -token $token -Verbose

        Write-Verbose "Updating repository $repoOwner/$repoName"
        $url = "https://api.github.com/repos/$repoOwner/$repoName"
        $headers = @{
            Authorization          = "Bearer $token"
            Accept                 = "application/vnd.github+json"
            "User-Agent"           = "PowerShell"
            "X-GitHub-Api-Version" = "2022-11-28"
        }
        $body = @{
            name         = $newName
            description  = $description
            homepage     = $homepage
            private      = $private
            has_issues   = $hasIssues
            has_projects = $hasProjects
            has_wiki     = $hasWiki
        } | ConvertTo-Json
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Patch -Body $body -ErrorAction Stop
        return $response
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq 404) {
            Write-Error "Repository not found. Please check the repository owner and name."
        }
        else {
            Write-Error "An error occurred while updating the repository: $_"
        }
    }
}

# Example usage:
<#
Update-GitHubRepo -repoOwner "SharkByte561"  `
    -repoName "NewRepo" `
    -token (Get-Secret 'gist' -AsPlainText) `
    -newName "NewRepoName" `
    -description "Updated description" `
    -homepage "https://github.com"   -Verbose

#>


