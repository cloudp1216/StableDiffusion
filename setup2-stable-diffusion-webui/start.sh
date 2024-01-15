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

function run() {
    docker run -d --restart=unless-stopped --name webui --gpus all -p 7860:7860 -p 2222:22 \
        -v $models:/home/webui/stable-diffusion-webui/models \
        -v $outputs:/home/webui/stable-diffusion-webui/outputs \
        -v $embeddings:/home/webui/stable-diffusion-webui/embeddings \
        -v $extensions:/home/webui/stable-diffusion-webui/extensions \
        webui sleep infinity
}

if [ `docker ps -a|grep webui -c 2>/dev/null` == "0" ]; then
    run
    echo "Please execute:"
    echo "    1. docker exec -it webui bash"
    echo "    2. cd stable-diffusion-webui"
    echo "    3. ./webui.sh --xformers --listen --skip-version-check --skip-prepare-environment --enable-insecure-extension-access --theme=dark"
else
    echo "Containers webui is existed."
fi


