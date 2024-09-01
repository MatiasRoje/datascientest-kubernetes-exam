#!/bin/bash

# Define variables
BACKUP_DIR="/home/ubuntu/backup"
TIMESTAMP=$(date +%d%m%Y)
BACKUP_FILE="${BACKUP_DIR}/k3s_backup_${TIMESTAMP}.zip"
S3_BUCKET="datascientest-kubernetes-exam-etcd-backup"

mkdir -p "${BACKUP_DIR}"

# Stop K3s to ensure data consistency (if possible)
# sudo systemctl stop k3s

# Create a zip archive of the K3s server directory
sudo zip -r "${BACKUP_FILE}" /var/lib/rancher/k3s/server/db /var/lib/rancher/k3s/server/token

# Upload the zip file to S3
aws s3 cp "${BACKUP_FILE}" s3://${S3_BUCKET}

# Start K3s again (if it was stopped)
# sudo systemctl start k3s

echo "Backup completed and uploaded to S3: ${BACKUP_FILE}"