#/bin/bash
docker build -t gcr.io/studious-set-280411/travis-ci-build-stages-demo .
gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json
gcloud --quiet config set project studious-set-280411
gcloud docker -- push gcr.io/studious-set-280411/travis-ci-build-stages-demo
yes | gcloud beta compute instances create my-instance \
            --project=studious-set-280411 \
            --zone us-east1-b \
            --source-machine-image gcr.io/studious-set-280411/travis-ci-build-stages-demo \
            --service-account travis@studious-set-280411.iam.gserviceaccount.com
      


