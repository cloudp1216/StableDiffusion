FROM ubuntu:20.04

COPY pkgs/ca-certificates_20230311ubuntu0.20.04.1_all.deb /tmp
COPY pkgs/libssl1.1_1.1.1f-1ubuntu2.19_amd64.deb /tmp
COPY pkgs/openssl_1.1.1f-1ubuntu2.19_amd64.deb /tmp
COPY pkgs/tini /usr/bin

RUN set -x \
        && dpkg -i /tmp/*.deb \
        && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse" > /etc/apt/sources.list \
        && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse" >> /etc/apt/sources.list \
        && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse" >> /etc/apt/sources.list \
        && echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list \
        && apt clean all && apt update \
        && export DEBIAN_FRONTEND=noninteractive \
        && apt install -y build-essential vim vim-common git curl primus-libs tzdata net-tools openssh-server sudo xdg-utils iproute2 \
        && ln -svf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone \
        && echo "/home/webui/anaconda3/lib" > /etc/ld.so.conf.d/anaconda3.conf \
        && useradd -m -s /bin/bash -G sudo webui \ 
        && echo "webui:webui" | chpasswd

USER webui 
RUN set -x \
        && cd ~ \
        && curl -O https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2023.03-1-Linux-x86_64.sh \
        && bash Anaconda3-2023.03-1-Linux-x86_64.sh -b -p /home/webui/anaconda3 \
        && echo ". /home/webui/anaconda3/etc/profile.d/conda.sh" >> /home/webui/.bashrc \
        && echo "conda activate" >> /home/webui/.bashrc \
        && unlink Anaconda3-2023.03-1-Linux-x86_64.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash"]

