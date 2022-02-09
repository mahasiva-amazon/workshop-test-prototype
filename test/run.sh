#!/bin/bash

if [ ! -z "$CLUSTER_NAME" ]; then
  echo "Using existing cluster $CLUSTER_NAME..."
  aws eks update-kubeconfig --name $CLUSTER_NAME
fi

npm test