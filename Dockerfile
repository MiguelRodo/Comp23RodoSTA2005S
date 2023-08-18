FROM rocker/verse:4.3
COPY ./scripts /template_script
RUN /template_script/all/setup_bashrc_d.sh &&  \
      /template_script/all/add_config_r.sh
RUN /template_script/ubuntu/install_apptainer.sh && \
      /template_script/ubuntu/install_gh.sh && \
      /template_script/apptainer/ubuntu/R/add_r_libs-select.sh && \
      /template_script/all/install_r.sh && \
      quarto install tinytex
