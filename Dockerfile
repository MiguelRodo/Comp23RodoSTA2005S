FROM rocker/verse:4.3
COPY ./scripts /template_script
RUN /template_script/all/setup_bashrc_d.sh &&  \
      /template_script/all/add_config_r.sh
