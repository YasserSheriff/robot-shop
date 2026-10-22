#!/bin/sh

cd "$(dirname "$0")" || exit 1

# get the tag info (optional, defaults to the public Docker Hub image)
if [ -f ../.env ]
then
    eval $(egrep '[A-Z]+=' ../.env)
fi
REPO=${REPO:-robotshop}
TAG=${TAG:-latest}

echo "Repo $REPO"
echo "Tag $TAG"

docker build -t ${REPO}/rs-load:${TAG} . && docker tag ${REPO}/rs-load:${TAG} ${REPO}/rs-load

if [ "$1" = "push" ]
then
    echo "pushing..."
    docker push ${REPO}/rs-load:${TAG}
    docker push ${REPO}/rs-load
fi
