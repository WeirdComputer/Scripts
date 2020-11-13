#!/usr/bin/bash

LN=/usr/bin/ln
TARGET=/usr/local/scripts/${1}
LINK=/usr/local/bin/$(echo $1 |sed 's/.sh//')
CHMOD=/usr/bin/chmod

$LN -s $TARGET $LINK

echo "Link made for $LINK > $TARGET"

$CHMOD +x $TARGET

echo "Added execute perms for $TARGET"
