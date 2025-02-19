# This Dockerfile generates the docker image that gets used by Gitlab CI
# To build it for arm64 and amd64 (YYYYMMDD.HHMM is the current date and time in UTC):
#   docker buildx create --use
#   docker buildx build --platform linux/amd64,linux/arm64/v8 \
#       -t registry.gitlab.com/buildroot.org/buildroot/base:YYYYMMDD.HHMM \
#       --push support/docker

# We use a specific tag for the base image *and* the corresponding date
# for the repository., so do not forget to update the apt-sources.list
# file that is shipped next to this Dockerfile.
FROM debian:bookworm-20250203

LABEL maintainer="Buildroot mailing list <buildroot@buildroot.org>" \
      vendor="Buildroot" \
description="Container with everything needed to run Buildroot"

# Architecture to build for
ARG TARGETPLATFORM

# We need tar >= 1.35
ARG TAR_VERSION="1.35"

# Setup environment
ENV DEBIAN_FRONTEND=noninteractive

# This repository can be a bit slow at times. Don't panic...
COPY apt-sources.list /etc/apt/sources.list

# Install 32bit variant on x86_64 image.
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    dpkg --add-architecture i386; \
fi

# The container has no package lists, so need to update first
RUN apt-get -o APT::Retries=3 update -y

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
    apt-get -o APT::Retries=3 install -y --no-install-recommends \
        g++-multilib \
        libc6:i386; \
fi

RUN apt-get -o APT::Retries=3 install -y --no-install-recommends \
        bc \
        build-essential \
        bzr \
        ca-certificates \
        cmake \
        cpio \
        curl \
        cvs \
        file \
        flake8 \
        g++ \
        git \
        libncurses5-dev \
        locales \
        mercurial \
        openssh-server \
        python3 \
        python3-flake8 \
        python3-magic \
        python3-nose2 \
        python3-pexpect \
        python3-pytest \
        qemu-system-arm \
        qemu-system-misc \
        qemu-system-x86 \
        rsync \
        shellcheck \
        subversion \
        unzip \
        wget \
        && \
    apt-get -y autoremove && \
    apt-get -y clean

# Build host-tar
RUN curl -sfL https://ftpmirror.gnu.org/tar/tar-${TAR_VERSION}.tar.xz | \
    tar -Jx -C /tmp && \
    cd /tmp/tar-${TAR_VERSION} && \
    FORCE_UNSAFE_CONFIGURE=1 ./configure \
        --disable-year2038 && \
    make && \
    make install && \
    rm -rf /tmp/tar-${TAR_VERSION}

# To be able to generate a toolchain with locales, enable one UTF-8 locale
RUN sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
    /usr/sbin/locale-gen

RUN useradd -ms /bin/bash br-user && \
    chown -R br-user:br-user /home/br-user

USER br-user
WORKDIR /home/br-user
ENV HOME=/home/br-user
ENV LC_ALL=en_US.UTF-8
