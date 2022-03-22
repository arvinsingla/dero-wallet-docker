FROM ubuntu:20.04

WORKDIR /dero

COPY get-latest-dero-release.sh .

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl wget \
    && chmod +x get-latest-dero-release.sh \
    && ./get-latest-dero-release.sh \
    && mv dero_linux_amd64/dero-wallet-cli-linux-amd64 /usr/local/bin

ENTRYPOINT ["dero-wallet-cli-linux-amd64"]
