#!/bin/bash
chmod +x scripts/*.sh
set -e  # Exit immediately if any command fails

# -----------------------------------------------
# Helper function: Wait until Docker daemon is ready
# -----------------------------------------------
function wait_for_docker() {
  echo "Waiting for Docker daemon to start..."
  while ! docker info >/dev/null 2>&1; do
    sleep 2
  done
  echo "Docker is ready."
}

# -----------------------------------------------
# Step 0: Check if Docker Desktop is installed
# -----------------------------------------------
echo "Checking Docker Desktop..."

DOCKER_PATH="/c/Program Files/Docker/Docker/Docker Desktop.exe"

# If Docker CLI or Docker Desktop not found, install using PowerShell
if ! command -v docker >/dev/null 2>&1 || [ ! -f "$DOCKER_PATH" ]; then
  echo "Docker CLI or Docker Desktop not found."
  echo "Installing Docker Desktop using PowerShell..."

  # ✅ FIXED LINE: Proper way to run a PowerShell script file from Bash
  powershell.exe -ExecutionPolicy Bypass -File "./scripts/setup_docker.ps1"


  echo "Waiting 20s for Docker Desktop to launch..."
  sleep 20
else
  echo "Docker Desktop is already installed."
  echo "Launching Docker Desktop..."

  # Launch Docker Desktop via PowerShell
  powershell.exe -Command "Start-Process '$DOCKER_PATH'"
  sleep 10
fi

# -----------------------------------------------
# Step 1: Wait until Docker is fully running
# -----------------------------------------------
wait_for_docker

echo "Step 0: Making all scripts in ./scripts executable..."
chmod +x scripts/*.sh
echo "All scripts made executable"
echo ""

echo "Step 1: Starting Minikube..."
./scripts/1_start_minikube.sh
echo "Minikube started"
echo ""

echo "Step 2: Installing Redis using Helm..."
./scripts/2_install_redis.sh
echo "Redis installed via Helm"
echo ""

echo "Step 3: Deploying redis-client using Helm chart..."
./scripts/3_deploy_redis-client.sh
echo "redis-client deployed"
echo ""

echo "Step 4: Waiting for pods to become Ready..."
kubectl wait --for=condition=Ready pod -l app=redis-client --timeout=60s || echo "redis-client pod may not be ready"
kubectl wait --for=condition=Ready pod -l app.kubernetes.io/component=master --timeout=60s || echo "redis master pod may not be ready"
echo "Pods are ready (or timed out with a warning)"
echo ""

echo "Step 5: Setting key in Redis..."
./scripts/4_set_key.sh   # Should output: OK
echo "Key set in Redis"
echo ""

echo "Step 6: Retrieving key from Redis..."
./scripts/5_get_key.sh   # Should output: \"OxValue\"
echo "Key retrieved from Redis"
echo ""

echo "All steps completed successfully!"

