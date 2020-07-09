#!/bin/bash

export BACKUP_ID=$(gcloud sql backups list --instance=$DB_INSTANCE_NAME_PROD | awk '{print $1}' |tail -1)
yes | gcloud sql backups restore $BACKUP_ID --restore-instance=$DB_INSTANCE_NAME_PROD  --async
export PENDING_OPERATIONS=$(gcloud sql operations list --instance=$DB_INSTANCE_NAME_PROD --filter='status=RUNNING' --format='value(name)' | sed '1!D')
export PENDING_DONE=$(gcloud sql operations list --instance=$DB_INSTANCE_NAME_PROD --filter='status=DONE' --format='value(name)' | sed '1!D')
while [ "$PENDING_OPERATIONS" != "$PENDING_DONE" ] 
do
PENDING_DONE=$(gcloud sql operations list --instance=$DB_INSTANCE_NAME_PROD --filter='status=DONE' --format='value(name)' | sed '1!D')
echo $WAIT
if [[ -z "$PENDING_OPERATIONS" ]]; then 
break
fi
sleep 10
done
gcloud sql operations wait $PENDING_DONE 