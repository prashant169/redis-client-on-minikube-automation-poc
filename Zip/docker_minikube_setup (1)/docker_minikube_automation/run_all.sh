#!/bin/bash
set -e

function wait_for_docker() {
  echo "⏳ Waiting for Docker daemon to start..."
  while ! docker info >/dev/null 2>&1; do
    sleep 2
  done
  echo "✅ Docker is ready."
}

echo "🔍 Checking Docker Desktop..."

DOCKER_PATH="/c/Program Files/Docker/Docker/Docker Desktop.exe"

if ! command -v docker >/dev/null 2>&1 || [ ! -f "$DOCKER_PATH" ]; then
  echo "❌ Docker CLI or Docker Desktop not found."
  echo "🚀 Installing Docker Desktop using PowerShell..."
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File "./scripts/setup_docker.ps1"
  echo "⌛ Waiting 20s for Docker Desktop to launch..."
  sleep 20
else
  echo "✅ Docker Desktop is already installed."
  echo "🚀 Launching Docker Desktop..."
  powershell.exe -Command "Start-Process '$DOCKER_PATH'"
  sleep 10
fi

wait_for_docker
