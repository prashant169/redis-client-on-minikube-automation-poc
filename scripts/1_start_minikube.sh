#!/bin/bash
set -e

echo "Starting Minikube + kubectl installation (Windows - Git Bash)..."

# Windows install paths (escaped for Git Bash)
KUBECTL_DIR="/c/Program Files/Kubernetes"
MINIKUBE_DIR="/c/Program Files/Minikube"

# Step 1: Install kubectl
if ! command -v kubectl &> /dev/null; then
  echo "Installing kubectl..."
  K8S_VERSION="v1.30.1"
  KUBECTL_URL="https://dl.k8s.io/release/${K8S_VERSION}/bin/windows/amd64/kubectl.exe"

  echo "Downloading kubectl from $KUBECTL_URL"
  curl --ssl-no-revoke -Lo kubectl.exe "$KUBECTL_URL"
  chmod +x kubectl.exe

  echo "Creating $KUBECTL_DIR if not exists"
  mkdir -p "$KUBECTL_DIR"
  mv -f kubectl.exe "$KUBECTL_DIR/kubectl.exe"

  echo "adding $KUBECTL_DIR to system PATH..."
  powershell.exe -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';C:\\Program Files\\Kubernetes', 'Machine')" || echo "Failed to update PATH for kubectl"
else
  echo "kubectl already installed"
fi

# Step 2: Install Minikube
if ! command -v minikube &> /dev/null; then
  echo "Installing Minikube..."
  MINIKUBE_URL="https://storage.googleapis.com/minikube/releases/latest/minikube-windows-amd64.exe"

  echo "Downloading Minikube from $MINIKUBE_URL"
  curl --ssl-no-revoke -Lo minikube.exe "$MINIKUBE_URL"
  chmod +x minikube.exe

  echo "Creating $MINIKUBE_DIR if not exists"
  mkdir -p "$MINIKUBE_DIR"
  mv -f minikube.exe "$MINIKUBE_DIR/minikube.exe"

  echo "Adding $MINIKUBE_DIR to system PATH..."
  powershell.exe -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';C:\\Program Files\\Minikube', 'Machine')" || echo "Failed to update PATH for Minikube"
else
  echo "Minikube already installed"
fi

# Step 3: Start Minikube
echo "Starting Minikube..."
/c/Program\ Files/Minikube/minikube.exe start --driver=docker

echo "Minikube and kubectl installed and running!"


