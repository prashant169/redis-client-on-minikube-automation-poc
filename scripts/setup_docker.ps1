# 📦 Check if Docker is already installed
$dockerInstalled = Get-Command "docker" -ErrorAction SilentlyContinue

if ($dockerInstalled) {
    Write-Host "✅ Docker is already installed."
} else {
    Write-Host "⬇️  Downloading Docker Desktop installer..."

    $installerUrl = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
    $installerPath = "$env:TEMP\DockerDesktopInstaller.exe"

    # Download Docker Desktop Installer
    Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath

    Write-Host "⚙️  Installing Docker Desktop..."
    Start-Process -FilePath $installerPath -Args "install", "--quiet" -Wait

    Write-Host "🚀 Launching Docker Desktop..."
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"

    Write-Host "✅ Docker Desktop installed and launched."
}

# Optional: Wait for Docker daemon to be ready
Write-Host "⌛ Waiting for Docker daemon to be ready..."
$maxRetries = 30
$retryCount = 0

while (-not (docker info 2>$null) -and ($retryCount -lt $maxRetries)) {
    Start-Sleep -Seconds 3
    $retryCount++
    Write-Host "⏳ Waiting... ($retryCount)"
}

if ($retryCount -ge $maxRetries) {
    Write-Host "❌ Docker daemon did not start in expected time."
    exit 1
}

Write-Host "✅ Docker daemon is ready."

