FROM rocker/verse:4.3
COPY ./scripts /template_script
RUN chmod +x /template_script/post_create_command.sh && \ 
      /template_script/post_create_command.sh