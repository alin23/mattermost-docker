#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u alinpanaitiu --password-stdin

TAG=$TRAVIS_COMMIT docker-compose push

if [[ "$TRAVIS_BRANCH" = "master" || "$TRAVIS_BRANCH" = "main" ]]; then
    docker-compose push
    curl --basic --user alin:$DEPLOY_PASSWORD --get -d "update=$UPDATE_COMMAND" -d "restart=$RESTART" https://deploy.darkwoods.win/$STACK
fi