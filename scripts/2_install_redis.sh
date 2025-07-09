#!/bin/bash
set -e

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install redis bitnami/redis --set auth.enabled=false

