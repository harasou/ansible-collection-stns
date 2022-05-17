# HACK: amd64
FROM ubuntu:jammy@sha256:aa6c2c047467afc828e77e306041b7fa4a65734fe3449a54aa9c280822b0d87d

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
      python3 \
      sudo \
      gpg \
      ca-certificates \
    && apt-get clean
