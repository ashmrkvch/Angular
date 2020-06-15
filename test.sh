#/bin/bash
docker build -t travis-ci-build-stages-demo .

echo $keyfile | base64 --decode -i > ${HOME}/${keyfile}

gcloud auth activate-service-account --key-file ${HOME}/${keyfile}
gcloud --quiet config set project studious-set-280411


docker images

docker tag travis-ci-build-stages-demo travis-ci-build-stages-demo 

gcloud docker push gcr.io/studious-set-280411/travis-ci-build-stages-demo     

yes | gcloud beta container images add-tag gcr.io/studious-set-280411/travis-ci-build-stages-demo :$TRAVIS_COMMIT gcr.io/studious-set-280411}/travis-ci-build-stages-demo :latest

docker run -d --rm travis-ci-build-stages-demo
