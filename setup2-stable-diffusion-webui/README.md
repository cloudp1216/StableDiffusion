

docker build -t webui .


```shell
注意，打包过程中如果出现问题，请使用加速：
RUN set -x \
        ...
        && python -m venv venv \
	&& . venv/bin/activate \
        && export HTTP_PROXY="http://x.x.x.x:1080" \
        && export HTTPS_PROXY="http://x.x.x.x:1080" \
        && export NO_PROXY="localhost,127.0.0.0" \
        && pip install --upgrade pip \
        ...
```


