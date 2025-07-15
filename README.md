# 📦 redis-client-on-minikube – DevOps Automation Assignment

This project automates the full lifecycle of a local Kubernetes environment using **Minikube**, **Docker Desktop**, **Helm**, and **Redis**, as part of the Ox Security DevOps assignment.

It includes:
- 🚀 Setup scripts to install Docker Desktop and Minikube
- 📦 Deploy Redis via Helm
- ⚙️ Deploy a custom Redis client Helm chart
- 🧪 Scripts to interact with Redis (set/get keys)
- 🧹 Cleanup script to uninstall everything

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
Redis-client-on-minikube/
├──  problem6 DevOps-Assignment.pdf   # Original problem statement
│ 
├── run_all.sh                       # Main script to execute everything in order Installs ,Docker-Desktop, Minikube, kubectl, and starts cluster
├── scripts/                         # Shell scripts to automate each step ,Full Redis deployment and test flow
│	├── setup_docker.ps1			  # Installs Docker Desktop on Window
│   ├── 1_start_minikube.sh	      # Starts Minikube cluster
│   ├── 2_install_redis.sh	      # Installs Redis Helm chart
│   ├── 3_deploy_redis-client.sh     # Deploys Redis client Helm chart
│   ├── 4_set_key.sh		      # Sets key OxKey with value OxValue
│   └── 5_get_key.sh		      # Gets value for key OxKey
│
├── helm-chart-redis-client/        # Custom Helm chart for Redis client pod
│   ├── Chart.yaml		     # Chart values (optional)
│   ├── values.yaml
│   └── templates/
│       └── deployment.yaml
│
├── unininstall_minikube.sh          # Full cleanup of Docker Desktop & Minikube
└── README.md
                      
```
---

## 🚀 Prerequisites

- OS: **Windows 10/11**
- **Git Bash**, **PowerShell**, and **Admin Access**
- Internet connection (to download Docker Desktop, Helm charts)

---

## 🧪 How to Run the Entire Assignment

### 🔹 Step 1: Open Git Bash as Administrator

Right-click **Git Bash** → Run as **Administrator**

### 🔹 Step 2: Run the main script

```bash
cd ox-devops-assignment/
chmod +x run_all.sh
./run_all.sh

#########

This will:

Install and launch Docker Desktop (if not installed)

Start Minikube

Install Redis via Helm

Deploy a Redis client pod

Set and Get a Redis key

########
This will:

Stop and delete Minikube cluster

Remove binaries and configuration

Uninstall Docker Desktop using PowerShell

########
How to Uninstall Everything
To clean up Docker Desktop and Minikube fully:

cd scripts/
chmod +x uninstall_minikube_and_docker.sh
./uninstall_minikube_and_docker.sh
########


Contact / Questions
For any queries related to the scripts or deployment process, please contact via GitHub or email.

## 👨‍💻 Author

**Prashant**  
DevOps Enthusiast | Automation Explorer
