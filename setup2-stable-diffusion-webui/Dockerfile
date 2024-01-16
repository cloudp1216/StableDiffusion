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
        && pip install --upgrade pip \
        && pip install /tmp/torch-2.0.1+cu118-cp310-cp310-linux_x86_64.whl \
        && bash webui.sh --skip-torch-cuda-test \
        && pip install -U -I --no-deps xformers==0.0.20 --prefer-binary \
        && sed 's/#start()/start()/g' launch.py -i \
        && echo "#!/bin/bash" >> start.sh \
        && echo "exec ./webui.sh --xformers --listen --skip-version-check --enable-insecure-extension-access --theme=dark" >> start.sh \
        && chmod 755 start.sh 

EXPOSE 7860

WORKDIR /home/webui

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["sleep", "infinity"]

