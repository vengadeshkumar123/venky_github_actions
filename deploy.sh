#!/bin/bash
set -e
AWS_REGION="ap-south-1"
AWS_ACCOUNT_ID="354780327224"
ECR_REPOSITORY="practice"
IMAGE_TAG="latest"

ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

IMAGE="${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"

CONTAINER_NAME="myapp-container"

aws ecr get-login-password \
  --region "$AWS_REGION" | \
docker login \
  --username AWS \
  --password-stdin "$ECR_REGISTRY"

docker pull "$IMAGE"
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 80:80 \
  "$IMAGE"

docker ps