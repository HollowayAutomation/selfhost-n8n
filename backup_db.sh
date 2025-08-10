#!/bin/bash

# Variables
DATE=$(date +%Y-%m-%d)
CONTAINER=n8n-docker-postgres-1
DB_USER=n8n-user
DB_NAME=n8n-db
BACKUP_FILE="n8n_backup_$DATE.sql.gz"
S3_BUCKET=s3://n8n-backups/

# Dump and compress
docker exec -t $CONTAINER pg_dump -U $DB_USER $DB_NAME | gzip > $BACKUP_FILE

# Upload to S3
aws s3 cp $BACKUP_FILE $S3_BUCKET  --endpoint-url https://vgxouffwwiebrqzupegk.supabase.co/storage/v1/s3

# Remove local file
rm $BACKUP_FILE