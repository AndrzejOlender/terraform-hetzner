#!/bin/bash
set -e

export NODE_1="168.119.224.111"
export NODE_2="168.119.226.54"
export NODE_3="168.119.226.35"
export VER="v1.21.3+k3s1"
export USER="root"

# The first server starts the cluster
k3sup install \
  --cluster \
  --user $USER \
  --ip $NODE_1 \
  --k3s-version $VER \
  --local-path $HOME/.kube/k3s-config \
  --tls-san $NODE_1
  # --k3s-extra-args "--no-deploy traefik"

# The second node joins
k3sup join \
  --server \
  --ip $NODE_2 \
  --user $USER \
  --k3s-version $VER \
  --server-user $USER \
  --server-ip $NODE_1
  # --k3s-extra-args "--no-deploy traefik"

# The third node joins
k3sup join \
  --server \
  --ip $NODE_3 \
  --user $USER \
  --k3s-version $VER \
  --server-user $USER \
  --server-ip $NODE_1
  # --k3s-extra-args "--no-deploy traefik"