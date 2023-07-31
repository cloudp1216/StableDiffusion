#!/bin/bash


path=$(cd `dirname $0`; pwd)


models="$path/models"
outputs="$path/outputs"


if [ ! -d "$models" ]; then
    mkdir -p $models
    chmod 777 $models
fi
if [ ! -d "$outputs" ]; then
    mkdir -p $outputs
    chmod 777 $outputs
fi


docker run -d --name webui --gpus all -p 7860:7860 -p 2222:22 \
        -v $models:/home/webui/stable-diffusion-webui/models \
        -v $outputs:/home/webui/stable-diffusion-webui/outputs \
        webui sleep infinity


echo "Please execute:"
echo "    1. docker exec -it webui bash"
echo "    2. cd stable-diffusion-webui"
echo "    3. ./webui.sh --xformers --listen"


