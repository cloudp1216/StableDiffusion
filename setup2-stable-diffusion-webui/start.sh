#!/bin/bash


path=$(cd `dirname $0`; pwd)


docker run -d --name webui --gpus all \
        -v $path/models:/home/webui/stable-diffusion-webui/models \
        -v $path/outputs:/home/webui/stable-diffusion-webui/outputs \
	sd sleep infinity


echo "Please enter the container to execute: ./webui.sh --xformers --listen"


