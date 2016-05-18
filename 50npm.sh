#!/bin/bash
. /opt/elasticbeanstalk/env.vars
function error_exit
{
  eventHelper.py --msg "$1" --severity ERROR
  exit $2
}

#avoid long NPM fetch hangups
npm config set fetch-retry-maxtimeout 15000

echo "------------------------------ — Installing/updating NPM modules, it might take a while, go take a leak or have a healthy snack... — -----------------------------------"
OUT=$([ -d "/tmp/deployment/application" ] && cd /tmp/deployment/application && /opt/elasticbeanstalk/node-install/node-v$NODE_VER-linux-$ARCH/bin/npm install --production) || error_exit "Failed to run npm install.  $OUT" $?
echo $OUT
