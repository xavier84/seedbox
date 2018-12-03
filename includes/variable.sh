#!/bin/bash -i


#couleus
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CPURPLE="${CSI}1;35m"
CCYAN="${CSI}1;36m"

#liste des appliquetions
LISTAPP="plex pyload medusa rtorrent radarr syncthing jackett lidarr portainer tautulli nextcloud heimdall"
#variables
BASEDIR="/usr/local/bin"
BASEDIRDOCKER="/usr/local/bin/dockers"
VOLUMES_TRAEFIK_PATH="/etc/traefik"

CONFDIR="/etc/seedbox-compose"
VERSION=$(cat /etc/debian_version)
OS=$(cat /etc/*release | grep ^NAME | tr -d 'NAME="')

