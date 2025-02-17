#!/bin/bash

echo "Build the docker for Base R"

docker buildx build . -f Dockerfile \
   --no-cache=false \
   --progress=plain \
   --tag r-shiny-vscode:v4-4-2
   # --build-arg PROJECT_NAME="R Shiny Dev" \
   # --build-arg VENV_NAME="R_DEV_ENV" \
   # --build-arg R_VERSION_MAJOR: "4" \
   # --build-arg R_VERSION_MINOR: "4" \
   # --build-arg R_VERSION_PATCH: "2" \
   # --build-arg DEBIAN_FRONTEND=noninteractive \
   # --build-arg CRAN_MIRROR=https://cran.rstudio.com/ \
   # --build-arg QUARTO_VER="1.6.40" \

if [[ $? = 0 ]] ; then
echo "R Docker image correctly created"
echo "Pushing docker..."
docker push r-shiny-vscode:v4-4-2
else
echo "Docker build failed"
fi
