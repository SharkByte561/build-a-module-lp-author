# ExampleModule Module

## Description
The ExampleModule is a PowerShell module that provides functions to interact with GitHub repositories. It includes functionalities to connect to GitHub, retrieve repository information, create new repositories, delete repositories, and update repository details.

## Installation
```powershell
Install-Module -Name ExampleModule
```

## Usage
```powershell
Import-Module ExampleModule
```

### Functions

#### Connect-ToGitHub
Connects to GitHub by retrieving or prompting for a GitHub token.

**Example:**
```powershell
Connect-ToGitHub
```

#### Get-GitHubRepo
Retrieves information about a GitHub repository.

**Parameters:**
- `repoOwner`: The GitHub username or organization name that owns the repository.
- `repoName`: The name of the GitHub repository.
- `token`: The GitHub token for authentication.

**Example:**
```powershell
Get-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster"
```

#### New-GitHubRepo
Creates a new GitHub repository.

**Parameters:**
- `repoName`: The name of the new GitHub repository.
- `token`: The GitHub token for authentication.
- `description`: A description of the new repository.
- `private`: Indicates whether the repository should be private. Defaults to `$false`.

**Example:**
```powershell
New-GitHubRepo -repoName "NewRepo" -description "This is a new repository" -private:$true
```

#### Remove-GitHubRepo
Deletes a GitHub repository.

**Parameters:**
- `repoOwner`: The GitHub username or organization name that owns the repository.
- `repoName`: The name of the GitHub repository.
- `token`: The GitHub token for authentication.

**Example:**
```powershell
Remove-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster"
```

#### Update-GitHubRepo
Updates a GitHub repository.

**Parameters:**
- `repoOwner`: The GitHub username or organization name that owns the repository.
- `repoName`: The name of the GitHub repository.
- `token`: The GitHub token for authentication.
- `newName`: The new name for the repository.
- `description`: A description of the repository.
- `homepage`: The URL of the repository's homepage.
- `private`: Indicates whether the repository should be private. Default is `$true`.
- `hasIssues`: Indicates whether the repository should have issues enabled. Default is `$true`.
- `hasProjects`: Indicates whether the repository should have projects enabled. Default is `$true`.
- `hasWiki`: Indicates whether the repository should have a wiki enabled. Default is `$true`.

**Example:**
```powershell
Update-GitHubRepo -repoOwner "SharkByte561" -repoName "SnippetMaster" -newName "NewRepoName" -description "Updated description" -homepage "https://github.com"
```
