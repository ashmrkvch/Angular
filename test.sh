#/bin/bash
docker build -t gcr.io/studious-set-280411/travis-ci-build-stages-demo .

echo $keyfile | base64 --decode -i > ${HOME}/studious-set-280411-db6dcfed0d74.json

gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json
gcloud --quiet config set project studious-set-280411

gcloud docker push gcr.io/studious-set-280411/travis-ci-build-stages-demo     


