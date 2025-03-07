# Windows Installation Script for Git Tools

# Get the current directory
$currentDir = $PSScriptRoot

# Create the path extension
$pathExtension = "$currentDir\bin"

# Add to PATH environment variable (for current session)
$env:Path += ";$pathExtension"

# Add to PATH environment variable (permanently)
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if (-not $currentPath.Contains($pathExtension)) {
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$pathExtension", "User")
    Write-Host "Added git-tools to your PATH environment variable!"
}

# Create PowerShell profile if it doesn't exist
if (-not (Test-Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File -Force | Out-Null
}

Write-Host "Installation complete! Please restart your PowerShell session to use the git-tools." 