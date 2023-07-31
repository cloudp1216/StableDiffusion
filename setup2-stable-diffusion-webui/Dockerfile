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
        && pip install --upgrade pip \
	&& pip install /tmp/torch-2.0.1+cu118-cp310-cp310-linux_x86_64.whl \
        && bash webui.sh --skip-torch-cuda-test \
        && sed 's/#start()/start()/g' launch.py -i

EXPOSE 7860

WORKDIR /home/webui

CMD ["sleep", "infinity"]

