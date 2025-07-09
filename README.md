# 📦 redis-client-on-minikube

A fully automated DevOps project to deploy a Redis instance and a custom Redis client on a local Minikube Kubernetes cluster using Helm and Bash scripts. Designed for local testing and DevOps demonstrations.

---

## 🚀 Features

- Installs Minikube and kubectl on Windows (via Git Bash or PowerShell)
- Deploys Redis via Helm
- Deploys a custom `redis-client` pod using a Helm chart
- Sets and retrieves a key (`OxKey=OxValue`) from Redis using `kubectl exec`
- Fully script-driven and repeatable

---

## 🧰 Tech Stack

| Tool        | Use                        |
|-------------|-----------------------------|
| Minikube    | Local Kubernetes cluster     |
| kubectl     | Kubernetes CLI               |
| Helm        | Kubernetes package manager   |
| Redis       | In-memory key-value database |
| Git Bash    | Script execution on Windows  |
| PowerShell  | Windows PATH configuration   |

---

## 📁 Project Structure

```
redis-client-on-minikube/
├── helm-chart-redis-client/         # Helm chart for redis-client pod
├── scripts/                         # Shell scripts to automate each step
├── run_all.sh                       # Installs Minikube, kubectl, and starts cluster
├── execute_all.sh                   # Full Redis deployment and test flow
├── unininstall_minikube.sh          # Uninstalls Minikube and removes PATH entries
├── nots.txt                         # Notes (optional)
└── problem6 DevOps-Assignment.pdf   # Original problem statement
```

---

## ✅ Getting Started

### 1️⃣ Install Minikube + kubectl (Windows Git Bash)
```bash
./run_all.sh
```

📌 **Run Git Bash as Administrator**

> This script:
> - Downloads and installs `kubectl` and `minikube.exe`
> - Adds them to the Windows system `PATH`
> - Starts the Minikube cluster

---

### 2️⃣ Run Full Redis Setup
```bash
./execute_all.sh
```

This script will:
- Start Minikube
- Install Redis via Helm
- Deploy a Redis client pod via a custom Helm chart
- Set a Redis key (`OxKey=OxValue`)
- Retrieve it back (`"OxValue"`)

---

## 📥 Expected Output

```
OK
"OxValue"
```

---

## 🧹 Uninstall Minikube

To remove Minikube completely (binary, cluster, config, and PATH):

```bash
./unininstall_minikube.sh
```

---

## 🗜️ Zip the Project (from Git Bash)

```bash
powershell.exe -Command "Compress-Archive -Path * -DestinationPath ox-devops-assignment.zip"
```

---

## 🧠 Notes

- Make sure Docker is installed and running (for Minikube Docker driver)
- Restart Git Bash after running `run_all.sh` to reload updated PATH
- Run all scripts from the root of your project folder

---

## 👨‍💻 Author

**Prashant**  
DevOps Enthusiast | Automation Explorer
