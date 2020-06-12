#/bin/bash
docker build -t travis-ci-build-stages-demo .
docker images
docker tag travis-ci-build-stages-demo travis-ci-build-stages-demo       
docker run -d --rm travis-ci-build-stages-demo
