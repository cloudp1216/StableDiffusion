#!/bin/bash


path=$(cd `dirname $0`; pwd)

models="$path/models"
outputs="$path/outputs"
embeddings="$path/embeddings"
extensions="$path/extensions"
dirs=(
    $models
    $outputs
    $embeddings
    $extensions
)

for i in ${dirs[@]}
do
    if [ ! -d "$i" ]; then
        mkdir -p $i
        chown 5000:5000 $i
    fi
done

docker run -d --restart=unless-stopped --name webui --gpus all -p 7860:7860 -p 2222:22 \
    -v $models:/home/webui/stable-diffusion-webui/models \
    -v $outputs:/home/webui/stable-diffusion-webui/outputs \
    -v $embeddings:/home/webui/stable-diffusion-webui/embeddings \
    -v $extensions:/home/webui/stable-diffusion-webui/extensions \
    webui sleep infinity

echo "Please execute:"
echo "    1. docker exec -it webui bash"
echo "    2. cd stable-diffusion-webui"
echo "    3. ./webui.sh --xformers --listen --enable-insecure-extension-access --theme=dark"


