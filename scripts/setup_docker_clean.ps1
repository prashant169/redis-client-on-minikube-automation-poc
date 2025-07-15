# -----------------------------------------------
# PowerShell script to install and launch Docker Desktop without winget
# -----------------------------------------------

Write-Host "ðŸ“¦ Checking for Docker Desktop..."

# Define installer URL (official stable release)
$installerUrl = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
$installerPath = "$env:TEMP\DockerDesktopInstaller.exe"
$dockerExe = "C:\Program Files\Docker\Docker\Docker Desktop.exe"

# Step 1: Check if Docker CLI exists
$dockerInstalled = Get-Command "docker" -ErrorAction SilentlyContinue

if ($dockerInstalled) {
    Write-Host "âœ… Docker CLI already installed."
} elseif (Test-Path $dockerExe) {
    Write-Host "âœ… Docker Desktop is already installed."
} else {
    Write-Host "â¬‡ï¸ Downloading Docker Desktop installer..."
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    if (-Not (Test-Path $installerPath)) {
        Write-Error "âŒ Failed to download Docker installer."
        exit 1
    }

    Write-Host "ðŸš€ Installing Docker Desktop (silent mode)..."
    Start-Process -FilePath $installerPath -ArgumentList "install", "--quiet" -Wait

    if ($LASTEXITCODE -ne 0) {
        Write-Error "âŒ Docker installation failed."
        exit 1
    }

    Write-Host "âœ… Docker Desktop installation complete."
}

# Step 2: Launch Docker Desktop if not already running
if (Test-Path $dockerExe) {
    Write-Host "ðŸš€ Launching Docker Desktop..."
    Start-Process -FilePath "$dockerExe"
    Start-Sleep -Seconds 10
} else {
    Write-Error "âŒ Docker executable not found even after install."
    exit 1
}

# Step 3: Check Docker CLI is working
Write-Host "â³ Waiting for Docker daemon..."

$maxWait = 60
$waited = 0
while ($waited -lt $maxWait) {
    try {
        docker info > $null 2>&1
        if ($?) {
            Write-Host "âœ… Docker is running!"
            exit 0
        }
    } catch {}
    Start-Sleep -Seconds 3
    $waited += 3
}


Write-Error "Docker daemon did not start within timeout."
exit 1

