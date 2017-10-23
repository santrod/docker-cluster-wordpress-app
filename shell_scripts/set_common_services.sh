#!/bin/bash

# Project will use redis
php /bin/wp --allow-root plugin install redis-cache --activate &&
sed -i '1 a define(\"WP_REDIS_HOST\", \"redis\");' /var/www/html/wp-config.php
