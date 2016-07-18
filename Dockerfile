FROM golang:1.7-alpine

ARG PYYAML_VERSION=3.11

# Install dependency packages
RUN set -ex \
    && apk add --update \
           python \
           git \
           curl \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && curl -O -L http://pyyaml.org/download/pyyaml/PyYAML-$PYYAML_VERSION.tar.gz \
    && tar -zxvf PyYAML-$PYYAML_VERSION.tar.gz \
    && cd PyYAML-$PYYAML_VERSION \
    && python setup.py install \
    && rm /tmp/PyYAML-$PYYAML_VERSION.tar.gz

# Install Dockerbeat
RUN set -ex \
    && go get github.com/Masterminds/glide \
    && go get github.com/ingensi/dockerbeat \
    && mkdir /etc/dockerbeat
COPY dockerbeat.yml /etc/dockerbeat/dockerbeat.yml

# Setup entrypoint
WORKDIR /etc/dockerbeat
COPY entrypoint.sh /etc/dockerbeat/entrypoint.sh
RUN chmod +x /etc/dockerbeat/entrypoint.sh
ENTRYPOINT /etc/dockerbeat/entrypoint.sh
