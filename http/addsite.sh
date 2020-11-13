#!/usr/bin/bash

DOMAIN=$1
LN=/usr/bin/ln
WWWDIR=/var/www/
CP=/usr/bin/cp
WWWSKEL=/etc/skel/www/
SED=/usr/bin/sed
CAT=/usr/bin/cat
SERVICE=/usr/sbin/service
CERTBOT=/usr/bin/certbot

ASITES=/etc/nginx/sites-available/
ESITES=/etc/nginx/sites-enabled/
DCONFFILE=${ASITES}${DOMAIN}.conf
DCONFLINKFILE=${ESITES}${DOMAIN}.conf

echo "Adding domain $DOMAIN to the server"

$CP -r ${WWWSKEL}example.com ${WWWDIR}${DOMAIN} 

echo "Copied directory structure from ${WWWSKEL} to ${WWWDIR}${DOMAIN}"

$CAT ${WWWSKEL}example.com.conf \
	| $SED "s/example.com/$DOMAIN/" \
	> $DCONFFILE 

echo "Created configuration file $DCONFFILE from template"

$LN -s $DCONFFILE $DCONFLINKFILE 

echo "$DCONFLINKFILE linked to $DCONFFILE"

$SERVICE nginx reload && echo "Nginx service reloaded"

$CERTBOT --nginx -d $DOMAIN
