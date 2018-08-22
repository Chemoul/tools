#!/usr/bin/env bash

CLIENT_ID=$1
CLIENT_TOKEN=$2
USER=$(whoami)

if [ -z "${CLIENT_ID}" ]; then
 echo "Blackfire CLIENT_ID is required"
 exit 1
fi

if [ -z "${CLIENT_TOKEN}" ]; then
 echo "Blackfire CLIENT_TOKEN is required"
 exit 1
fi

su -c "yum install pygpgme -y"
su -c "yum install wget -y"
wget -O - "http://packages.blackfire.io/fedora/blackfire.repo" | su -c "tee /etc/yum.repos.d/blackfire.repo"
su -c "yum install blackfire-agent -y"

BLACKFIRE_PATH=/home/${USER}/.blackfire.ini
cp blackfire.ini ${BLACKFIRE_PATH}
sed -i -e "s/__CLIENT_ID__/${CLIENT_ID}/g" ${BLACKFIRE_PATH}
sed -i -e "s/__CLIENT_TOKEN__/${CLIENT_TOKEN}/g" ${BLACKFIRE_PATH}

su -c "yum install blackfire-php -y"

