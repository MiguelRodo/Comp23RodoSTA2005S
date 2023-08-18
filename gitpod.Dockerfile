FROM rocker/verse:4.3

COPY ./scripts /template_script

RUN /template_script/all/install_r.sh
RUN /template_script/apptainer/ubuntu/R/add_r_libs-select.sh
RUN /template_script/ubuntu/install_apptainer.sh

# Create the gitpod user. UID must be 33333.
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod

USER gitpod

RUN /template_script/all/setup_bashrc_d.sh &&  \
      /template_script/all/add_config_r.sh
