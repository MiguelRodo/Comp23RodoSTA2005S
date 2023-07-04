#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM gitpod/workspace-full:latest

COPY scripts/ubuntu /project/scripts

WORKDIR /project/scripts

RUN ./install_apptainer.sh
RUN ./install_gh.sh
