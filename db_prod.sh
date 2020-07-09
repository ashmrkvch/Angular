gcloud --quiet config set project studious-set-280411
gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json

yes | gcloud sql backups create --instance $DB_INSTANCE_NAME_PROD
npm run migrations