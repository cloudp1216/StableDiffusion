FROM webui

USER webui

RUN set -x \
        && cd /home/webui/stable-diffusion-webui \
        && sed 's/start()/#start()/g' launch.py -i \
        && cd extensions \
        && git clone https://github.com/dtlnor/stable-diffusion-webui-localization-zh_CN.git \
        && git clone https://github.com/Physton/sd-webui-prompt-all-in-one.git \
        && git clone https://github.com/thisjam/sd-webui-oldsix-prompt.git \
        && git clone https://github.com/Mikubill/sd-webui-controlnet.git \
        && git clone https://github.com/Bing-su/adetailer.git \
        && git clone https://github.com/Coyote-A/ultimate-upscale-for-automatic1111.git \
        && cd /home/webui/stable-diffusion-webui \
        && bash webui.sh --skip-torch-cuda-test --enable-insecure-extension-access \
        && sed 's/#start()/start()/g' launch.py -i 

EXPOSE 7860

WORKDIR /home/webui

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]

