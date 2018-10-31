FROM debian:stable-slim

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.ustc.edu.cn/' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y --install-recommends \
        wget unzip \
    && rm -r /var/lib/apt/lists/*

ENV RUNNER=mindoc
RUN useradd -m ${RUNNER}

WORKDIR /home/${RUNNER}

ENV MINDOC_VERSION=1.0.2
RUN runuser -u ${RUNNER} -- wget https://github.com/lifei6671/mindoc/releases/download/v${MINDOC_VERSION}/mindoc_linux_amd64.zip \
    && runuser -u ${RUNNER} -- unzip mindoc_linux_amd64.zip \
    && rm -rf mindoc_linux_amd64.zip

COPY start.sh /usr/local/bin/

EXPOSE 8181

CMD ["start.sh"]
