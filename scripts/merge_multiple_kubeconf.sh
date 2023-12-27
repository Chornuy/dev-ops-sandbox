#!/bin/bash
KUBECONFIG_DEFAULT_PATH=".kube"
KUBERNETES_BACKUP_FILE_NAME="config-backup.yaml"
KUBERNETES_CONFIG_FILE_NAME="config"
KUBERNETES_MERGED_FILE_NAME="all-in-one-kubeconfig.yaml"

KUBECONFIG_PATH="${HOME}/${KUBECONFIG_DEFAULT_PATH}"
KUBECONFIG_PATH_FILE_NAME="${KUBECONFIG_PATH}/${KUBERNETES_CONFIG_FILE_NAME}"
BACKUP_FILE_PATH="${KUBECONFIG_PATH}/${KUBERNETES_BACKUP_FILE_NAME}"
MERGED_FILE_PATH="${KUBECONFIG_PATH}/${KUBERNETES_MERGED_FILE_NAME}"


echo "Creating backup config under file name: config-backup.yml." 

cp "$KUBECONFIG_PATH_FILE_NAME" "$BACKUP_FILE_PATH"

export KUBECONFIG=$(find ~/.kube/ -maxdepth 1 ! -path 'cache' -type f | tr '\n' ':')

kubectl config view --flatten > "$MERGED_FILE_PATH"

mv "$MERGED_FILE_PATH" "$KUBECONFIG_PATH_FILE_NAME"
