#!/bin/bash
php /bin/wp --allow-root option update siteurl "$VIRTUAL_PROTO"://"$VIRTUAL_HOST" &&
php /bin/wp --allow-root option update home "$VIRTUAL_PROTO"://"$VIRTUAL_HOST";
