#/bin/bash
docker build -t gcr.io/studious-set-280411/travis-ci-build-stages-demo .
gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json
gcloud --quiet config set project studious-set-280411
gcloud docker -- push gcr.io/studious-set-280411/travis-ci-build-stages-demo
yes | gcloud compute instances create-with-container my-instance  --zone us-east1-b --container-image=gcr.io/studious-set-280411/travis-ci-build-stages-demo