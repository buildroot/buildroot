FROM gitpod/workspace-full-vnc

RUN apt get update && \
    apt install -y rsync cpio
# Install custom tools, runtimes, etc.
# For example "bastet", a command-line tetris clone:
# RUN brew install bastet
#
# More information: https://www.gitpod.io/docs/config-docker/
