FROM rocker/verse:4.3
COPY ./scripts/all/post_create_command.sh /template_script/post_create_command.sh
RUN chmod +x /template_script/post_create_command.sh && \ 
      /template_script/post_create_command.sh