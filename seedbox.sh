#!/bin/bash


while :; do
. /usr/local/bin/includes/functions.sh
. /usr/local/bin/includes/variable.sh
clear
logo.sh
echo ""
echo -e "${CCYAN}INSTALLATION${CEND}"
	echo -e "${CGREEN}${CEND}"
	echo -e "${CGREEN}   1) Installation/réinstallation  de docker && docker-compose (Ubuntu, Debian) ${CEND}"
	echo -e "${CGREEN}   2) Configuration des variables pour docker-compose ${CEND}"
	echo -e "${CGREEN}   3) Applications ${CEND}"
	echo -e "${CGREEN}   4) Sécuriser la Seedbox ${CEND}"
	echo -e "${CGREEN}   5) Sauvegarde && Restauration${CEND}"
	echo -e "${CGREEN}   6) Quitter ${CEND}"
	echo -e ""
	read -p "Votre choix [1-6]: " -e -i 1 PORT_CHOICE

	case $PORT_CHOICE in
		1) ## Installation de docker et docker-compose
			logo.sh
			echo -e "${CGREEN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}					INSTALLATION DOCKER ET DOCKER-COMPOSE						   ${CEND}"
			echo -e "${CGREEN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo ""
			# Installation possible sur debian ou ubuntu
			if [ "$OS" = "Ubuntu" ]
			then
				apt update && apt upgrade -y
				apt install apache2-utils curl unzip -y
				curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
				curl -fsSL https://get.docker.com -o get-docker.sh
				sh get-docker.sh
                curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
				mkdir -p /etc/apache2
				touch /etc/apache2/.htpasswd
				clear
				logo.sh
				echo -e "${CCYAN}Installation docker & docker compose terminée${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour revenir au menu principal"

			else
				apt update && apt upgrade -y
				apt install apache2-utils curl unzip -y
				curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
				curl -fsSL https://get.docker.com -o get-docker.sh
				sh get-docker.sh
                curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose
                mkdir -p /etc/apache2
				touch /etc/apache2/.htpasswd
				clear
				logo.sh
				echo -e "${CCYAN}Installation docker & docker compose terminée${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour revenir au menu principal"

				fi

		;;

		2) 	## Mise en place des variables necéssaire au docker-compose
			clear
			logo.sh
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}					PRECISONS SUR LES VARIABLES							  ${CEND}"
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CGREEN}		Cette étape permet une installation personnalisée configurable à vos besoins				 ${CEND}"
			echo -e "${CGREEN}		Une fois les variables définies, la configuration sera complètement automatisée 			 ${CEND}"
			echo -e "${CRED}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}															 ${CEND}"
			echo -e "${CCYAN}				UNE ATTENTION PARTICULIERE EST REQUISE POUR CETTE ETAPE					 ${CEND}"
			echo -e "${CCYAN}															 ${CEND}"
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CGREEN}${CEND}"
			## définition des variables

			echo -e "${CCYAN}Nom de domaine ${CEND}"
			read -rp "DOMAIN = " DOMAIN

			echo  ""
			echo -e "${CCYAN}Nom d'utilisateur pour l'authentification WEB ${CEND}"
			read -rp "USERNAME = " USERNAME

			echo  ""
			echo -e "${CCYAN}Mot de passe pour l'authentification WEB ${CEND}"
			read -rp "PASSWD = " PASSWD


			echo ""
			echo -e "${CCYAN}Adresse mail ${CEND}"
			read -rp "MAIL = " MAIL

			useradd -M -s /bin/bash "$USERNAME"
			echo "${USERNAME}:${PASSWD}" | chpasswd
			mkdir -p /home/"$USERNAME"
			chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"
			htpasswd -bs /etc/apache2/.htpasswd "$USERNAME" "$PASSWD"
			htpasswd -cbs /etc/apache2/.htpasswd_"$USERNAME" "$USERNAME" "$PASSWD"
			VAR=$(sed -e 's/\$/\$$/g' /etc/apache2/.htpasswd_"$USERNAME" 2>/dev/null)
			export VOLUMES_ROOT_PATH=/home/"$USERNAME"
			export PASSWD

			clear
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}				LES VARIABLES CI DESSOUS DONT DEFINIES PAR DEFAULT				  ${CEND}"
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CRED}	${CCYAN}TRAEFIK_DASHBOARD_URL:${CRED}	traefik.${DOMAIN}	  						  ${CEND}"
			echo -e "${CRED}	${CCYAN}PLEX_FQDN:${CRED}		plex.${DOMAIN} 			  				  	  ${CEND}"
			echo -e "${CRED}	${CCYAN}PYLOAD_FQDN:${CRED}		pyload.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}MEDUSA_FQDN:${CRED}		medusa.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}RTORRENT_FQDN:${CRED}		rtorrent.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}RADARR_FQDN:${CRED}		radarr.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}SYNCTHING_FQDN:${CRED}		syncthing.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}JACKETT_FQDN:${CRED}		jackett.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}LIDARR_FQDN:${CRED}		lidarr.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}PORTAINER_FQDN:${CRED}		portainer.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}TAUTULLI_FQDN:${CRED}		tautulli.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}NEXTCLOUD_FQDN:${CRED}		nextcloud.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}	${CCYAN}HEIMDALL_FQDN:${CRED}		heimdall.${DOMAIN}							  ${CEND}"
			echo -e "${CRED}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CGREEN}				VOUS POUVEZ MODIFIER TOUTES CES VARIABLES A VOTRE CONVENANCE				  ${CEND}"
			echo -e "${CGREEN}				TAPER ENSUITE SUR LA TOUCHE ENTREE POUR VALIDER 					  ${CEND}"
			echo -e "${CRED}-------------------------------------------------------------------------------------------------------------------------${CEND}"

			read -rp "Voulez-vous modifier les variables ci dessus ? (o/n) : " EXCLUDE
			echo""
			if [[ "$EXCLUDE" = "o" ]] || [[ "$EXCLUDE" = "O" ]]; then

			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}				JUSTE SAISIR LE SOUS DOMAINE ET NON LE DOMAINE						  ${CEND}"
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"

			echo -e "${CCYAN}Sous domaine de Traefik${CEND}"
			read -rp "TRAEFIK_DASHBOARD_URL = " TRAEFIK_DASHBOARD_URL

				if [ -n "$TRAEFIK_DASHBOARD_URL" ]
				then
					export TRAEFIK_DASHBOARD_URL=${TRAEFIK_DASHBOARD_URL}.${DOMAIN}
				else
					export TRAEFIK_DASHBOARD_URL=traefik.${DOMAIN}
				fi

				for DOM in ${LISTAPP}
				do
					echo -e "${CCYAN}Sous domaine de ${DOM}${CEND}"
					DOMMAJ=$(echo "$DOM" | tr "[:lower:]" "[:upper:]")
					read -rp "${DOMMAJ}_FQDN = " DOM_FQDN
					DOMMAJ=$(echo "$DOM" | tr "[:lower:]" "[:upper:]")

					if [ -n "$DOM_FQDN" ]
					then
			 			export ${DOMMAJ}_FQDN=${DOM_FQDN}.${DOMAIN}
					else
			 			export ${DOMMAJ}_FQDN=${DOM}.${DOMAIN}
					fi
				done
			else
			 		export TRAEFIK_DASHBOARD_URL=traefik.${DOMAIN}
					for DOM in ${LISTAPP}
					do
						DOMMAJ=$(echo "$DOM" | tr "[:lower:]" "[:upper:]")
						export ${DOMMAJ}_FQDN=${DOM}.${DOMAIN}
					done
			fi

			export PROXY_NETWORK=traefik_proxy
			## Création d'un fichier .env

			cat <<- EOF > /mnt/.env
			FILMS=$FILMS
			SERIES=$SERIES
			ANIMES=$ANIMES
			MUSIC=$MUSIC
			VOLUMES_ROOT_PATH=$VOLUMES_ROOT_PATH
			VAR=$VAR
			MAIL=$MAIL
			USERNAME=$USERNAME
			PASSWD=$PASSWD
			DOMAIN=$DOMAIN
			PASS=$PASS
			PROXY_NETWORK=$PROXY_NETWORK
			TRAEFIK_DASHBOARD_URL=$TRAEFIK_DASHBOARD_URL
			PLEX_FQDN=$PLEX_FQDN
			LIDARR_FQDN=$LIDARR_FQDN
			MEDUSA_FQDN=$MEDUSA_FQDN
			RTORRENT_FQDN=$RTORRENT_FQDN
			RADARR_FQDN=$RADARR_FQDN
			PORTAINER_FQDN=$PORTAINER_FQDN
			JACKETT_FQDN=$JACKETT_FQDN
			NEXTCLOUD_FQDN=$NEXTCLOUD_FQDN
			TAUTULLI_FQDN=$TAUTULLI_FQDN
			SYNCTHING_FQDN=$SYNCTHING_FQDN
			PYLOAD_FQDN=$PYLOAD_FQDN
			HEIMDALL_FQDN=$HEIMDALL_FQDN

			EOF

			docker network create traefik_proxy 2>/dev/null
			docker network create torrent 2>/dev/null

			mkdir -p ${VOLUMES_TRAEFIK_PATH}
			cp /usr/local/bin/dockers/traefik/traefik.toml  ${VOLUMES_TRAEFIK_PATH}/traefik.toml
			cp /usr/local/bin/dockers/traefik/docker-compose.yml ${VOLUMES_TRAEFIK_PATH}/docker-compose.yml

			sed -i "s|@MAIL@|$MAIL|g;" ${VOLUMES_TRAEFIK_PATH}/traefik.toml
			sed -i "s|@DOMAIN@|$DOMAIN|g;" ${VOLUMES_TRAEFIK_PATH}/traefik.toml

			sed -i "s|@TRAEFIK_DASHBOARD_URL@|$VOLUMES_TRAEFIK_PATH|g;" ${VOLUMES_TRAEFIK_PATH}/docker-compose.yml
			sed -i "s|@PROXY_NETWORK@|$PROXY_NETWORK|g;" ${VOLUMES_TRAEFIK_PATH}/docker-compose.yml
			sed -i "s|@VAR@|$VAR|g;" ${VOLUMES_TRAEFIK_PATH}/docker-compose.yml



			clear
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo -e "${CCYAN}					VERIFICATION ET MISE EN ROUTE DE TRAEFIK				  ${CEND}"
			echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
			echo ""
			echo ""
			progress-bar 20
			docker-compose -f ${VOLUMES_TRAEFIK_PATH}/docker-compose.yml up -d
			echo ""
			echo -e "${CCYAN}La configuration des variables s'est parfaitement déroulée ${CEND}"
			echo ""
			read -p "Appuyer sur la touche Entrer pour continuer"
			seedbox.sh
		;;


		3)
			clear
			logo.sh
			export $(xargs </mnt/.env)
			cd /mnt
			APPLI=""
			sortir=false
			while [ !sortir ]
			do
			echo ""
			echo -e "${CRED}-----------------${CEND}"
			echo -e "${CCYAN}  APPLICATIONS  ${CEND}"
			echo -e "${CRED}-----------------${CEND}"
			echo ""
			echo -e "${CGREEN}   1) Plex ${CEND}"
			echo -e "${CGREEN}   2) Rtorrent ${CEND}"
			echo -e "${CGREEN}   3) Radarr ${CEND}"
			echo -e "${CGREEN}   4) Lidarr ${CEND}"
			echo -e "${CGREEN}   5) Medusa ${CEND}"
			echo -e "${CGREEN}   6) Pyload ${CEND}"
			echo -e "${CGREEN}   7) Syncthing ${CEND}"
			echo -e "${CGREEN}   8) Jackett ${CEND}"
			echo -e "${CGREEN}   9) Portainer ${CEND}"
			echo -e "${CGREEN}   10) Tautulli ${CEND}"
			echo -e "${CGREEN}   11) Heimball ${CEND}"
			echo -e "${CGREEN}   12) Nextcloud ${CEND}"
			echo -e "${CGREEN}   13) Retour Menu Principal ${CEND}"
			echo ""
			read -p "Appli choix [1-13]: " -e -i 1 APPLI
			echo ""
			case $APPLI in
				1)
				if ps -e | grep -q Plex; then
					echo -e "${CGREEN}Plex est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					# CLAIM pour Plex
					echo ""
					echo -e "${CCYAN}Un token est nécéssaire pour AUTHENTIFIER le serveur Plex ${CEND}"
					echo -e "${CCYAN}Pour obtenir un identifiant CLAIM, allez à cette adresse et copier le dans le terminal ${CEND}"
					echo -e "${CRED}https://www.plex.tv/claim/ ${CEND}"
					echo ""
					read -rp "CLAIM = " CLAIM

					if [ -n "$CLAIM" ]
					then
						sed -i -e "s/PLEX_CLAIM=/PLEX_CLAIM=${CLAIM}/g" /mnt/docker-compose.yml
					fi

					## Lancement de Plex
					docker-compose up -d plex 2>/dev/null
					echo ""
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de Plex réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				2)
				if docker ps -a | grep -q torrent; then
					echo -e "${CGREEN}rtorrent est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					export $(xargs </mnt/.env)
					docker-compose up -d torrent
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de Rtorrent réussie${CEND}"
					echo ""

					# Configuration pour le téléchargement en manuel avec filebot
					docker exec -t torrent rm -rf /data/Media/*
					rm -rf $VOLUMES_ROOT_PATH/Medias/*
					docker exec -t torrent mkdir -p /data/Media/${FILMS}
					docker exec -t torrent mkdir -p /data/Media/${SERIES}
					docker exec -t torrent mkdir -p /data/Media/${MUSIC}
					docker exec -t torrent mkdir -p /data/Media/${ANIMES}
					docker exec -t torrent sed -i -e "s/Movies/${FILMS}/g" /usr/local/bin/postdl
					docker exec -t torrent sed -i -e "s/TV/${SERIES}/g" /usr/local/bin/postdl
					docker exec -t torrent sed -i -e "s/Music/${MUSIC}/g" /usr/local/bin/postdl
					docker exec -t torrent sed -i -e "s/Animes/${ANIMES}/g" /usr/local/bin/postdl
					docker exec -t torrent sed -i '/*)/,/;;/d' /usr/local/bin/postdl
					docker exec -t torrent chown -R 1001:1001 /mnt
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				3)

				if docker ps -a | grep -q radarr; then
					echo -e "${CGREEN}Radarr est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d radarr 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de radarr réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				4)

				if docker ps -a | grep -q lidarr; then
					echo -e "${CGREEN}Lidarr est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d lidarr 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de lidarr réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;


				5)
				if docker ps -a | grep -q medusa; then
					echo -e "${CGREEN}Medusa est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d medusa 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de medusa réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				6)
				if docker ps -a | grep -q pyload; then
					echo -e "${CGREEN}Pyload est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d pyload 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de pyload réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				7)
				if docker ps -a | grep -q syncthing; then
					echo -e "${CGREEN}Syncthing est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d syncthing 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de syncthing réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				8)
				if docker ps -a | grep -q jackett; then
					echo -e "${CGREEN}Jackett est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d jackett 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de Jackett réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				9)
				if docker ps -a | grep -q portainer; then
					echo -e "${CGREEN}Ombi est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d portainer 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de portainer réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				10)
				if docker ps -a | grep -q tautulli; then
					echo -e "${CGREEN}Tautulli est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d tautulli 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de Tautulli réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				11)
				if docker ps -a | grep -q heimdall; then
					echo -e "${CGREEN}Heimdall est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d heimdall 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de heimdall réussie${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour continuer"
					clear
					logo.sh
				fi

				;;

				12)
				if docker ps -a | grep -q nextcloud; then
					echo -e "${CGREEN}Nextcloud est déjà lancé${CEND}"
					echo ""
					read -p "Appuyer sur la touche Entrer pour retourner au menu"
					clear
					logo.sh
				else
					docker-compose up -d nextcloud 2>/dev/null
					progress-bar 20
					echo ""
					echo -e "${CGREEN}Installation de nextcloud réussie${CEND}"

				echo ""
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}       Paramètre de connection Nextcloud		 ${CEND}"
				echo -e "${CCYAN}							 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CGREEN}    	- identifiants (Ce que vous voulez)		 ${CEND}"
				echo -e "${CGREEN}    	- Utilisateur base de donnée: nextcloud		 ${CEND}"
				echo -e "${CGREEN}    	- passwd: $PASS					 ${CEND}"
				echo -e "${CGREEN}    	- Nom de la base de donnée: nextcloud		 ${CEND}"
				echo -e "${CGREEN}    	- hote: mariadb					 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}       Ne pas oublier de choisir mysql/mariadb		 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				fi

				;;

				13)
				sortir=true
				seedbox.sh

				;;

			esac
			done

		;;

		4)
		clear
		logo.sh
		OUTIL=""
		sortir=false
		while [ !sortir ]
		do
		echo ""
		echo -e "${CRED}--------------------------------${CEND}"
		echo -e "${CCYAN}    SECURISER LA SEEDBOX	${CEND}"
		echo -e "${CRED}--------------------------------${CEND}"
		echo ""
		echo -e "${CGREEN}   1) Changer le passwd de root ${CEND}"
		echo -e "${CGREEN}   2) Modifier l'utilisateur pour l'authentification web${CEND}"
		echo -e "${CGREEN}   3) Modification du port ssh && Mise en place serveur mail${CEND}"
		echo -e "${CGREEN}   4) Configuration Fail2ban && Portsentry && Iptables${CEND}"

		echo -e ""
			read -p "Outil choix [1-4]: " -e -i 1 OUTIL
			echo ""
			case $OUTIL in

				1) # Changer le passwd de root dans putty
				clear
				logo.sh
				echo ""
				echo -e "${CCYAN}Cette étape permet de changer le passwd de root ${CEND}"
				echo ""
				passwd root
				echo ""
				echo -e "${CCYAN}Le passwd a été modifié avec succés ${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				;;

				2) # Changer l'identification des applis docker
				export $(xargs </mnt/.env)
				clear
				logo.sh
				echo ""
				echo -e "${CCYAN}Cette étape permet de changer l'identification de vos applis docker ${CEND}"
				echo ""
				read -rp "Taper le nom de l'utilisateur " USER
				PASSWD=$(htpasswd -c /etc/apache2/.htpasswd $USER 2>/dev/null)
				PASSWD=$(sed -e 's/\$/\$$/g' /etc/apache2/.htpasswd 2>/dev/null)
				sed -i -e "s|traefik.frontend.auth.basic=.*|traefik.frontend.auth.basic=$PASSWD|g" /mnt/docker-compose.yml

				# On relance les containers actifs pour prendre en compte les modifs apportées au docker-compose && recréation de la configuration filebot
				cd /mnt
				var=$(docker-compose ps --filter names | awk {'print $1'} | sed '1,2d')
				docker-compose up -d $var
				progress-bar 20
				echo ""
				echo -e "${CGREEN}Paramètres d'identification mis à jour avec succès${CEND}"
				echo ""

				# Configuration pour le téléchargement en manuel avec filebot
				docker exec -t torrent rm -rf /data/Media/*
				rm -rf $VOLUMES_ROOT_PATH/Medias/*
				docker exec -t torrent mkdir -p /data/Media/${FILMS}
				docker exec -t torrent mkdir -p /data/Media/${SERIES}
				docker exec -t torrent mkdir -p /data/Media/${MUSIC}
				docker exec -t torrent mkdir -p /data/Media/${ANIMES}
				docker exec -t torrent sed -i -e "s/Movies/${FILMS}/g" /usr/local/bin/postdl
				docker exec -t torrent sed -i -e "s/TV/${SERIES}/g" /usr/local/bin/postdl
				docker exec -t torrent sed -i -e "s/Music/${MUSIC}/g" /usr/local/bin/postdl
				docker exec -t torrent sed -i -e "s/Animes/${ANIMES}/g" /usr/local/bin/postdl
				docker exec -t torrent sed -i '/*)/,/;;/d' /usr/local/bin/postdl
				docker exec -t torrent chown -R 1001:1001 /mnt
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				;;

				3) # Modification du port ssh et mise en place serveur mail

				## Configuration postfix pour les mails
				export $(xargs </mnt/.env)
				HOST=$(hostname)
				IP=$(curl ifconfig.me)
				echo "$IP" "$HOST.$DOMAIN" "$HOST" >> /etc/hosts
				echo ""
				echo -e "${CCYAN}Mise en place du serveur Mail${CEND}"
				echo ""
				echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
				echo -e "${CCYAN}					PRECISONS IMPORTANTES								  ${CEND}"
				echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
				echo -e "${CGREEN}		DECLARER LE HOSTNAME AUPRES DU REGISTRAR (enregistrement A pointant sur l'ip)				  ${CEND}"
				echo -e "${CGREEN}		Pour trouver le hostname taper "hostname" en ligne de commande						  ${CEND}"
				echo -e "${CRED}--------------------------------------------------------------------------------------------------------------------------${CEND}"
				echo -e "${CCYAN}															  ${CEND}"
				echo -e "${CCYAN}		Installation postfix : laisser SITE INTERNET par default						  ${CEND}"
				echo -e "${CCYAN}				       Nom de courrier: taper l'hostname trouvé précédement				  ${CEND}"
				echo -e "${CCYAN}-------------------------------------------------------------------------------------------------------------------------${CEND}"
				echo -e "${CGREEN}${CEND}"
				read -p "Appuyer sur la touche Entrer pour continuer"
				apt install -f postfix mailutils logwatch -y
				echo "root: $MAIL" >> /etc/aliases
				newaliases
				echo "echo 'Acces Shell Root le ' \`date\` \`who\` | mail -s 'Connexion serveur via root' root" >> /root/.bashrc
				service postfix restart
				sed -i -e 's/Output = stdout/Output = mail/g' /usr/share/logwatch/default.conf/logwatch.conf
				cat <<- EOF > /usr/share/logwatch/default.conf/logfiles/traefik.conf

				########################################################
				# Define log file group for nginx
				########################################################

				# What actual file? Defaults to LogPath if not absolute path….
				LogFile = traefik/*access.log

				# If the archives are searched, here is one or more line
				# (optionally containing wildcards) that tell where they are…
				#If you use a “-” in naming add that as well -mgt
				Archive = traefik/*access.log*


				# Expand the repeats (actually just removes them now)
				*ExpandRepeats

				# Keep only the lines in the proper date range…
				*ApplyhttpDate

				# vi: shiftwidth=3 tabstop=3
				EOF

				cp /usr/share/logwatch/default.conf/services/http.conf /usr/share/logwatch/default.conf/services/traefik.conf
				sed -i -e 's/httpd/traefik/g' /usr/share/logwatch/default.conf/services/traefik.conf
				sed -i -e 's/http/traefik/g' /usr/share/logwatch/default.conf/services/traefik.conf
				echo ""
				cp /usr/share/logwatch/scripts/services/http /usr/share/logwatch/scripts/services/traefik
				logwatch restart
				echo -e "${CCYAN}Le serveur Mail est configuré avec succés Mail${CEND}"
				echo""
				read -p "Appuyer sur la touche Entrer pour continuer"
				echo ""

				## configuration ssh
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}         Changement des paramètres de connexion SSH	 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo ""
				read -rp "Choisir un nom d'utilisateur " NAME
				mkdir /home/$NAME
				useradd -s /bin/bash $NAME
				echo ""
				echo -e "${CCYAN}Définir un mot de passe utilisateur${CEND}"
				passwd $NAME
				chown -R $NAME:$NAME /home/$NAME
				cat <<- EOF >> /etc/ssh/sshd_config
				AllowUsers $NAME
				EOF
				echo ""
				read -rp "Choisir un port ssh (Entre 22 et 65 536) " PORT
				sed -i -e "s/#Port/Port/g" /etc/ssh/sshd_config
				sed -i -e "s/Port 22/Port $PORT/g" /etc/ssh/sshd_config
				sed -i -e "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
				echo ""
				progress-bar 20
				echo ""
				service sshd restart

				echo -e "${CCYAN}Le port ssh a été changé avec succés${CEND}"
				echo ""
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}    La connection root est maintenant désactivée        ${CEND}"
				echo -e "${CCYAN}    Nouveaux paramètres de connection:		         ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CGREEN}    	- Port: $PORT				         ${CEND}"
				echo -e "${CGREEN}    	- Username: $NAME			         ${CEND}"
				echo -e "${CGREEN}    	- Passwd: mot de passe créé précédemment         ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}    Pour passer en root, taper su + mot de passe root	 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				;;

				4) # Installation Fail2ban et portsentry
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				echo -e "${CCYAN}    Installation Fail2ban, Portsentry, Iptables	 ${CEND}"
				echo -e "${CRED}---------------------------------------------------------${CEND}"
				read -p "Appuyer sur la touche Entrer pour continuer"
				export $(xargs </mnt/.env)
				apt install fail2ban portsentry -y
				echo ""
				read -rp "Quel est votre port ssh ? " PORT
				echo ""

				# Récupération ip serveur et ip domicile
				IP_DOM=$(grep 'Accepted' /var/log/auth.log | cut -d ' ' -f11 | head -1)
				IP_SERV=$(hostname -I)

				# Jail ssh
				cat <<- EOF > /etc/fail2ban/jail.d/custom.conf
				[DEFAULT]
				ignoreip = 127.0.0.1 $IP_DOM
				findtime = 3600
				bantime = 600
				maxretry = 3

				[sshd]
				enabled = true
				port = $PORT
				logpath = /var/log/auth.log
				banaction = iptables-multiport
				maxretry = 5
				EOF

				# Jail traefik
				cat <<- EOF > /etc/fail2ban/jail.d/traefik.conf
				[DEFAULT]
				ignoreip = 127.0.0.1 $IP_DOM
				findtime = 3600
				bantime = 600
				maxretry = 3

				[traefik-auth]
				enabled = true
				logpath = /var/log/traefik/access.log
				port = http,https
				banaction = docker-action
				maxretry = 2

				[traefik-botsearch]
				enabled = true
				logpath = /var/log/traefik/access.log
				maxretry = 1
				port = http,https
				banaction = iptables-multiport

				[traefik-badbots]
				enabled = true
				filter = apache-badbots
				logpath = /var/log/traefik/access.log
				maxretry = 1
				port = http,https
				banaction = iptables-multiport
				EOF

				# Regex traefik
				cat <<- EOF > /etc/fail2ban/filter.d/traefik-auth.conf
				[Definition]
				failregex = ^<HOST> \- \S+ \[\] \"(GET|POST|HEAD) .+\" 401 .+$
				ignoreregex =
				EOF

				cat <<- EOF > /etc/fail2ban/filter.d/traefik-botsearch.conf
				[INCLUDES]
				before = botsearch-common.conf

				[Definition]
				failregex = ^<HOST> \- \S+ \[\] \"(GET|POST|HEAD) \/<block> \S+\" 404 .+$
				EOF

				# Action Traefik
				cat <<- EOF > /etc/fail2ban/action.d/docker-action.conf
				[Definition]

				actionstart = iptables -N f2b-traefik-auth
              				iptables -A f2b-traefik-auth -j RETURN
              				iptables -I FORWARD -p tcp -m multiport --dports 443 -j f2b-traefik-auth

				actionstop = iptables -D FORWARD -p tcp -m multiport --dports 443 -j f2b-traefik-auth
             				iptables -F f2b-traefik-auth
             				iptables -X f2b-traefik-auth

				actioncheck = iptables -n -L FORWARD | grep -q 'f2b-traefik-auth[ \t]'

				actionban = iptables -I f2b-traefik-auth -s <ip> -j DROP

				actionunban = iptables -D f2b-traefik-auth -s <ip> -j DROP
				EOF

				# redémarrage des services
				cd /mnt
				docker-compose rm -fs traefik && docker-compose up -d traefik
				systemctl restart fail2ban
				fail2ban-client reload
				progress-bar 20
				echo ""
				echo -e "${CCYAN}Fail2ban a été configuré avec succés${CEND}"
				echo ""

				# Configuration Portsentry
				echo "$IP_DOM" >> /etc/portsentry/portsentry.ignore.static
				echo "$IP_SERV" >> /etc/portsentry/portsentry.ignore.static
				echo "66.249.64.0/19" >> /etc/portsentry/portsentry.ignore.static
				sed -i -e 's/BLOCK_UDP="0"/BLOCK_UDP="1"/g' /etc/portsentry/portsentry.conf
				sed -i -e 's/BLOCK_TCP="0"/BLOCK_TCP="1"/g' /etc/portsentry/portsentry.conf
				sed -i -e 's/#KILL_RUN_CMD_FIRST = "0"/KILL_RUN_CMD_FIRST = "1"/g' /etc/portsentry/portsentry.conf
				sed -i -e 's/SCAN_TRIGGER="0"/SCAN_TRIGGER="1"/g' /etc/portsentry/portsentry.conf
				sed -i -e 's/TCP_MODE="tcp"/TCP_MODE="atcp"/g' /etc/default/portsentry
				sed -i -e 's/UDP_MODE="udp"/UDP_MODE="audp"/g' /etc/default/portsentry
				echo KILL_ROUTE="/sbin/iptables -I INPUT -s \$TARGET$ -j DROP && /sbin/iptables -I INPUT -s \$TARGET$ -m limit --limit 3/minute --limit-burst 5 -j LOG --log-level DEBUG --log-prefix 'Portsentry: dropping: '" >> /etc/portsentry/portsentry.conf
				systemctl restart portsentry
				progress-bar 20
				echo ""
				echo -e "${CCYAN}Portsentry a été configuré avec succés${CEND}"
				echo ""

				# Mise en place iptables
				sed -i -e 's/22/'$PORT'/g' /etc/iptables
				read -p "Appuyer sur la touche Entrer pour continuer"
				chmod +x /etc/iptables
				/etc/iptables clear
				/etc/iptables start
				apt install iptables-persistent -y
				progress-bar 20
				echo ""
				echo -e "${CCYAN}Iptables a été configuré avec succés${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				echo ""
				clear
				logo.sh
				;;

			esac
			done
			;;

		5) # Sauvegarde de la configuration
		clear
		logo.sh
		SAUVE=""
		sortir=false
		while [ !sortir ]
		do
		echo ""
		echo -e "${CRED}------------------------------${CEND}"
		echo -e "${CCYAN}  SAUVEGARDE - RESTAURATION  ${CEND}"
		echo -e "${CRED}------------------------------${CEND}"
		echo ""
		echo -e "${CGREEN}   1) Sauvegarde des volumes docker et de toute la configuration seedbox ${CEND}"
		echo -e "${CGREEN}   2) Restauration complète de la seedbox ${CEND}"
		echo -e "${CGREEN}   3) Retour Menu Principal${CEND}"
		echo -e ""
			read -p "Sauve choix [1-3]: " -e -i 1 SAUVE
			echo ""
			case $SAUVE in

				1) # Sauvegarde des volumes
				clear
				logo.sh
				echo ""
				export $(xargs </mnt/.env)
				read -rp  "Préciser l'emplacement où vous souhaitez conserver la sauvegarde (exemple: /mnt/sauve): " EXCLUDE
				mkdir -p $EXCLUDE
				echo ""
				read -rp  "Nom que vous souhaitez attribuer à votre sauvegarde (exemple: backup): " SAUVE
				cd /
				ARCHIVE=$EXCLUDE/$SAUVE
				cat <<- EOF >> /mnt/.env
				ARCHIVE=$ARCHIVE
				EOF
				tar -zcf $EXCLUDE/$SAUVE.gz --exclude=Medias ${VOLUMES_ROOT_PATH} /mnt/docker-compose.yml /mnt/.env 2>/dev/null
				echo ""
				progress-bar 20
				echo ""
				echo -e "${CCYAN}La sauvegarde complète de la seedbox s'est bien déroulée ${CEND}"
				echo -e "${CCYAN}Il est important de sauvegarder précieusement l'archive :${CPURPLE} $ARCHIVE.gz ${CEND}"
				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				;;

				2) # Restauration
				clear
				logo.sh
				echo ""
				read -rp "Préciser l'emplacement de l'archive (exemple: /mnt/sauve/backup.gz : " ARCHIVE
				cd /

				if [ -f "$ARCHIVE" ];then
					echo -e "${CCYAN}Archive trouvée, restauration en cours des volumes ${CEND}"
					tar xzf $ARCHIVE 2>/dev/null
					echo ""
					progress-bar 20
					echo ""
						echo -e "${CCYAN}La restauration des volumes s'est bien déroulée ${CEND}"
						echo ""
						echo -e "${CCYAN}Restauration en cours des containers ${CEND}"
						echo ""
						cd /mnt
						docker-compose up -d
						echo ""
						echo -e "${CCYAN}Restauration complète de la seedbox terminée avec succés ${CEND}"

				else
					echo ""
					echo -e "${CCYAN}Archive non trouvée, recherche sur le serveur ... ${CEND}"
					RESULTAT=$(find / -name $ARCHIVE 2>/dev/null)
					if [ -f "$RESULTAT" ];then
						echo ""
						echo -e "${CCYAN}Archive trouvée à cet emplacement ${CPURPLE}$RESULTAT${CCYAN}, restauration en cours des volumes ${CEND}"
						tar xzf $RESULTAT
						progress-bar 20
						echo ""
						echo -e "${CCYAN}La restauration des volumes s'est bien déroulée ${CEND}"
						echo ""
						echo -e "${CCYAN}Restauration en cours des containers ${CEND}"
						echo ""
						cd /mnt
						docker-compose up -d
						echo ""
						echo -e "${CCYAN}Restauration complète de la seedbox terminée avec succés ${CEND}"

					else
						echo ""
						progress-bar 20
						echo ""
						echo -e "${CRED}Aucune archive de sauvegarde n'est présente sur le serveur${CEND}"

					fi

				echo ""
				read -p "Appuyer sur la touche Entrer pour continuer"
				clear
				logo.sh

				fi

				;;

				3) # quitter
				sortir=true
				seedbox.sh
				;;

			esac
			done
			;;

		6)
		exit 0
		;;
		*)
				echo ""
				progress-bar 5
				echo ""
				echo -e "${CRED}Maucvais choix${CEND}"

	esac
done