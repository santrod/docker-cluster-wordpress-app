#!/bin/bash
php /bin/wp --allow-root option update siteurl "$SITEURL_PROTO"://"$SITEURL" &&
php /bin/wp --allow-root option update home "$HOMEURL_PROTO"://"$HOMEURLT";
