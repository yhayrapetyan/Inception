#!/bin/sh

if [ ! -e ./wp-config.php ]; then
    rm -rf *
    wp core download --allow-root

    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DB/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

	  rm -rf ./wp-config-sample.php
fi

if ! wp db query "SHOW TABLES LIKE 'wp_users';" --allow-root | grep -q "wp_users"; then
      echo "\033[32mWordPress tables not found. Running wp core install...\033[0m"

      wp core install --url=$DOMAIN_NAME \
                      --title=$WP_TITLE \
                      --admin_user=$WP_ROOT_USER_USERNAME \
                      --admin_password=$WP_ROOT_USER_PASSWORD \
                      --admin_email=$WP_ROOT_USER_EMAIL --skip-email --allow-root

      # Create an additional WordPress user
      wp user create $WP_USER_USERNAME $WP_USER_EMAIL --role=$WP_USER_ROLE --user_pass=$WP_USER_PASSWORD --allow-root

      # Update plugins
      wp plugin update --all --allow-root

      # Set permissions
      chmod -R a+w wp-config.php wp-content
      chown -R www-data:www-data wp-config.php wp-content

      # Install and configure Redis plugin
      wp plugin install redis-cache --activate --allow-root
      wp config set WP_REDIS_HOST $REDIS_HOSTNAME --allow-root > /dev/null
      wp config set WP_REDIS_PORT $REDIS_PORT --raw --allow-root > /dev/null
      wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root > /dev/null
      wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root > /dev/null
      wp config set WP_REDIS_CLIENT phpredis --allow-root > /dev/null
	  echo "\033[32mRedis configured successfully\033[0m"
else
      echo "\033[32mWordPress tables already exist. Skipping installation.\033[0m"
fi

if wp core update --allow-root; then
    echo "\033[32mWordPress core updated successfully.\033[0m"
else
    echo "\033[31mFailed to update WordPress core.\033[0m"
fi

wp redis enable --allow-root

/usr/sbin/php-fpm8.2 -F