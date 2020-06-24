#/bin/bash
gcloud --quiet config set project studious-set-280411
gsutil cp gs://bucket-test__anhelina/test.txt /home/angular/test.txt
docker build -t gcr.io/studious-set-280411/travis-ci-build-stages-demo .
gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json

gcloud docker -- push gcr.io/studious-set-280411/travis-ci-build-stages-demo
#yes | gcloud compute instances create-with-container my-instance  --zone us-east1-b --container-image=gcr.io/studious-set-280411/travis-ci-build-stages-demo --tags=http-server
#gcloud compute firewall-rules create "http-rule" --allow=tcp:80 --source-ranges="0.0.0.0/0" --target-tags=http-server
yes | gcloud compute instances update-container my-instance  --zone us-east1-b --container-image=gcr.io/studious-set-280411/travis-ci-build-stages-demo 

sleep 12
ssh -o StrictHostKeyChecking=no -i id_rsa anhelina@35.211.249.83 -v
docker image prune -a -f
exit
