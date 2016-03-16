#!/usr/bin/env bash
set -euo

export tmp_static=`mktemp -d`/static/
export tmp_old=`mktemp -d`
export dev_version=/srv/cdn.jupyter.org/notebook/latest

/srv/cdn.jupyter.org/notebook/build-jupyter-static $tmp_static
mv $dev_version $tmp_old
mv $tmp_static $dev_version
rm -rf $tmp_old && rm -rf $tmp_static
