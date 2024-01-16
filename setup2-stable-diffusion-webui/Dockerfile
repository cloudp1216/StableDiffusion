FROM anaconda3:2023.03-1

COPY torch/torch-2.0.1+cu118-cp310-cp310-linux_x86_64.whl /tmp

USER webui

RUN set -x \
        && cd ~ \
        && . anaconda3/etc/profile.d/conda.sh \
        && conda activate \
        && git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git \
        && cd stable-diffusion-webui \
        && mkdir -p outputs \
        && sed 's/start()/#start()/g' launch.py -i \
        && python -m venv venv \
        && . venv/bin/activate \
        && echo ". stable-diffusion-webui/venv/bin/activate" >> ~/.bashrc \
        # 启用代理
        # && export HTTP_PROXY="http://x.x.x.x:1080" \
        # && export HTTPS_PROXY="http://x.x.x.x:1080" \
        # && export NO_PROXY="localhost,127.0.0.1" \
        && pip install --upgrade pip \
        && pip install /tmp/torch-2.0.1+cu118-cp310-cp310-linux_x86_64.whl \
        && bash webui.sh --skip-torch-cuda-test \
        # 注：xformers==0.0.20 从 cat modules/launch_utils.py | grep 'xformers' 命令中获取
        && pip install -U -I --no-deps xformers==0.0.20 --prefer-binary \
        && sed 's/#start()/start()/g' launch.py -i

EXPOSE 7860

WORKDIR /home/webui

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]

