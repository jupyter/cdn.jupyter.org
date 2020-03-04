FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update \
 && apt-get -y install \
        python3 \
        python3-pip \
        git \
        nginx \
 && apt-get clean && rm -rf /var/lib/apt/lists/*


# install Python requirements for scripts
ADD requirements.txt /tmp/requirements.txt
RUN python3 -m pip install --no-cache --upgrade pip \
 && python3 -m pip install --no-cache -r /tmp/requirements.txt

# install nginx configuration as default
ADD docker/jupyter-cdn.nginx /etc/nginx/sites-available/default
ADD docker/jupyter-cdn-ssl.nginx /etc/nginx/sites-available/jupyter-cdn-ssl

# add scripts twice in case /srv is mounted as a volume for persistence
# TODO: don't require scripts to be in content directory
ADD notebook /srv/cdn.jupyter.org/notebook
ADD notebook /src/cdn.jupyter.org/notebook

# entrypoint
ADD docker/cron-lite /usr/local/bin/cron-lite
ADD docker/jupyter-cdn-entrypoint /usr/local/bin/juptyer-cdn-entrypoint
EXPOSE 80
ENTRYPOINT ["/usr/local/bin/juptyer-cdn-entrypoint"]
CMD ["nginx", "-g", "daemon off;"]
