# cdn.jupyter.org

Layout and scripts for cdn.jupyter.org.

Clone this repo to `/srv/cdn.jupyter.org`,
and add `notebook/jupyter-cdn-cron` as a cron job
(e.g. copy it to `/etc/cron.hourly/`) to keep the resources up-to-date.

There is an example nginx config for serving /srv/cdn.jupyter.org at cdn.jupyter.org

This is currently running on the Jupyter multipurpose server at Rackspace.
