#!/bin/bash -i

checking_errors() {
	if [[ "$1" == "0" ]]; then
		echo -e "	${GREEN}--> Operation "$2" success !${NC}"
	else
		echo -e "	${RED}--> Operation "$2" failed !${NC}"
	fi
}

sed_docker() {
sed -i \
	-e "s|@FILMS@|$FILMS|g" \
	-e "s|@SERIES@|$SERIES|g" \
	-e "s|@ANIMES@|$ANIMES|g" \
	-e "s|@MUSIC@|$MUSIC|g" \
	-e "s|@VOLUMES_ROOT_PATH@|$VOLUMES_ROOT_PATH|g" \
	-e "s|@VAR@|$VAR|g" \
	-e "s|@MAIL@|$MAIL|g" \
	-e "s|@USERNAME@|$USERNAME|g" \
	-e "s|@PASSWD@|$PASSWD|g" \
	-e "s|@DOMAIN@|$DOMAIN|g" \
	-e "s|@PASS@|$PASS|g" \
	-e "s|@PROXY_NETWORK@|$PROXY_NETWORK|g" \
	-e "s|@TRAEFIK_DASHBOARD_URL@|$TRAEFIK_DASHBOARD_URL|g" \
	-e "s|@PLEX_FQDN@|$PLEX_FQDN|g" \
	-e "s|@LIDARR_FQDN@|$LIDARR_FQDN|g" \
	-e "s|@MEDUSA_FQDN@|$MEDUSA_FQDN|g" \
	-e "s|@RTORRENT_FQDN@|$RTORRENT_FQDN|g" \
	-e "s|@RADARR_FQDN@|$RADARR_FQDN|g" \
	-e "s|@PORTAINER_FQDN@|$PORTAINER_FQDN|g" \
	-e "s|@JACKETT_FQDN@|$JACKETT_FQDN|g" \
	-e "s|@NEXTCLOUD_FQDN@|$NEXTCLOUD_FQDN|g" \
	-e "s|@TAUTULLI_FQDN@|$TAUTULLI_FQDN|g" \
	-e "s|@SYNCTHING_FQDN@|$SYNCTHING_FQDN|g" \
	-e "s|@PYLOAD_FQDN@|$PYLOAD_FQDN|g" \
	-e "s|@HEIMDALL_FQDN@|$HEIMDALL_FQDN|g" \
	"$1"
}



progress-bar() {
  local duration=${1}
printf '\n'
echo -e "${CGREEN}Patientez ...	${CEND}"
printf '\n'

    already_done() { for ((done=0; done<$elapsed; done++)); do printf "#"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 0.2
      clean_line
  done
  clean_line
printf '\n'
}


calcul_port () {
	HISTO=$(wc -l < "$CONFDIR"/ports.txt)
	PORT=$(( $(($1))+HISTO ))
	PORT1=$(( $(($2))+HISTO ))
}

add_domain() {
echo -e "${CCYAN}Sous domaine de $1 ${CEND}"
DOMMAJ=$(echo "$1" | tr "[:lower:]" "[:upper:]")
read -rp "${DOMMAJ}_FQDN = " DOM_FQDN


if [ -n "$DOM_FQDN" ]
then
	export DOM_FQDN=${DOM_FQDN}.${DOMAIN}
else
	DOM_FQDN="$1".${DOMAIN}
	export DOM_FQDN
fi
}