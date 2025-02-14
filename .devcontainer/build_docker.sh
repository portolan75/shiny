#!/bin/bash

echo "Build the docker for Base R"

docker buildx build . -f Dockerfile \
   --progress=plain \
   --tag r-shiny-vscode:v4.4.2
   #    --platform linux/amd64 \
   #    --no-cache=true \
   #    --build-arg PROJECT_NAME="EIA Data Automation" \
   #    --build-arg VENV_NAME="LEARN_GITHUB_ACTIONS" \
   #    --build-arg DEBIAN_FRONTEND=noninteractive \
   #    --build-arg QUARTO_VER=1.6.40 

if [[ $? = 0 ]] ; then
echo "R Docker image correctly created"
echo "Pushing docker..."
docker push r-shiny-vscode:v4.4.2
else
echo "Docker build failed"
fi
