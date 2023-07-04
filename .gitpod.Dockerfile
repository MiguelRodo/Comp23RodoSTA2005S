#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM mcr.microsoft.com/devcontainers/universal:2.4-focal

COPY scripts/ubuntu /project/scripts

WORKDIR /project/scripts

RUN ./install_apptainer.sh
RUN ./install_gh.sh
