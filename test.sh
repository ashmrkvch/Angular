#/bin/bash

gcloud --quiet config set project studious-set-280411
gcloud auth activate-service-account --key-file ${HOME}/studious-set-280411-db6dcfed0d74.json
gcloud --quiet config set container/cluster $CLUSTER_NAME
gcloud --quiet config set compute/zone ${CLOUDSDK_COMPUTE_ZONE}
gcloud --quiet container clusters get-credentials $CLUSTER_NAME

gsutil cp gs://bucket-test__anhelina/test.txt test.txt
docker build -t gcr.io/studious-set-280411/travis-ci-build-stages-demo .
gcloud docker -- push gcr.io/studious-set-280411/travis-ci-build-stages-demo

#yes | gcloud compute instances create-with-container my-instance  --zone us-east1-b --container-image=gcr.io/studious-set-280411/travis-ci-build-stages-demo --tags=http-server
#gcloud compute firewall-rules create "http-rule" --allow=tcp:80 --source-ranges="0.0.0.0/0" --target-tags=http-server
#yes | gcloud compute instances update-container my-instance  --zone us-east1-b --container-image=gcr.io/studious-set-280411/travis-ci-build-stages-demo 
kubectl apply -f pod-test.yaml
sleep 12
kubectl get pod test-travis
#kubectl exec -ti test-travis --  /bin/sh 
# ssh -o StrictHostKeyChecking=no -i id_rsa anhelina@35.211.249.83 -v
#docker image prune -a -f
exit
