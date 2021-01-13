# TODO Create "qmstr" image with only the `qmstr` binary
FROM ubuntu:18.04 AS module

# Setup
WORKDIR /home
ENV GOROOT /opt/go
ENV PATH ${GOPATH}/bin:/opt/go/bin:$PATH
ENV DEBIAN_FRONTEND=noninteractive

# Installing dependencies
RUN apt-get update \
    && \
    apt-get install -y \
        curl \
        autoconf \
        make \
        git \
        libgit2-dev \
        libio-captureoutput-perl \
        virtualenv \
        tar \
        build-essential \
        pkg-config \
        protobuf-compiler \
        maven \
    && \
    rm -rf /var/lib/apt/lists/*

# Installing Golang
ARG GO_VERSION
RUN curl -o /opt/go.tar.gz \
    https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
WORKDIR /opt
RUN tar -xf go.tar.gz

# Downloading Quartermaster
# TODO Use releases in the future
ARG QMSTR_REPO_URL
ARG QMSTR_COMMIT_HASH
WORKDIR /home
RUN git clone \
    ${QMSTR_REPO_URL} \
    qmstr
WORKDIR /home/qmstr
RUN git reset --hard \
    ${QMSTR_COMMIT_HASH}

ARG GOPROXY

# Tests
RUN make gotest
