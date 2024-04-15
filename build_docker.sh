#! /bin/bash
#
# Docker Image: 
# =============================================================================
# Build docker image
# =============================================================================

## REGISTRY="dockercentral.it.example.com:5100/"
REGISTRY=""  # Docker Hub is implied.
NAMESPACE="com.example.dev"
IMAGE_NAME="flask_rest_api_sample"
TAG="1.0"

DOCKERFILE=Dockerfile

FULL_IMAGE_NAME="${REGISTRY}${NAMESPACE}/${IMAGE_NAME}:${TAG}"

# Docker Registry Login
# =============================================================================
# Private Docker Registry requires a login but Docker Hub does not.
# =============================================================================
## docker login -u user@dev.example.com --password fake ${REGISTRY}

docker build -t $FULL_IMAGE_NAME ./ \
    --build-arg http_proxy=$http_proxy \
    --build-arg https_proxy=$https_proxy \
    -f ${DOCKERFILE}
