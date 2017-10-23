#!/bin/bash
cd /var/www/html && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && mv wp-cli.phar /bin/wp && chmod 755 /bin/wp &&
php /bin/wp --allow-root option update siteurl "$VIRTUAL_PROTO"://"$VIRTUAL_HOST" &&
php /bin/wp --allow-root option update home "$VIRTUAL_PROTO"://"$VIRTUAL_HOST";
