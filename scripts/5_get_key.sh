#!/bin/bash
set -e

POD_NAME=$(kubectl get pods -l app=redis-client -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it "$POD_NAME" -- redis-cli -h redis-master GET OxKey

