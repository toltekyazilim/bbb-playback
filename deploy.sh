#!/bin/bash

set -e

BBB_PLAYBACK_HOMEPAGE=player
BBB_PLAYBACK=/home/toltek/$BBB_PLAYBACK_HOMEPAGE

export REACT_APP_BBB_PLAYBACK_BUILD=$(git rev-parse --short HEAD)

npm run-script build
sudo rm -rf $BBB_PLAYBACK
sudo cp -r ./build $BBB_PLAYBACK
sudo chown --recursive bigbluebutton:bigbluebutton $BBB_PLAYBACK

BBB_NGINX_FILES_PATH=/home/toltek/nginx/
if [ ! -f $BBB_NGINX_FILES_PATH/bbb-playback.nginx ]; then
  sudo cp ./bbb-playback.nginx $BBB_NGINX_FILES_PATH
  sudo systemctl reload nginx
fi
