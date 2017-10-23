#!/bin/bash

# Project will use redis
# TODO: search option if exists replace if not append
php /bin/wp --allow-root plugin install redis-cache --activate &&
sed -i '1 a define(\"WP_REDIS_HOST\", \"redis\");' /var/www/html/wp-config.php
sed -i '1 a define(\"WP_REDIS_DISABLED\", \"false\");' /var/www/html/wp-config.php
