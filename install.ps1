# Windows Installation Script for Git Tools

# Check if dialog is installed (via Chocolatey)
if (-not (Get-Command dialog -ErrorAction SilentlyContinue)) {
    Write-Host "Installing dialog via Chocolatey..."
    
    # Check if Chocolatey is installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Chocolatey is not installed. Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }
    
    # Install dialog
    choco install dialog -y
}

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