FROM innoq/iqvoc_postgresql

USER root
RUN apt update && apt install -y postgresql-contrib
