# Dockerfile
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive TZ=Europe/Paris APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_LOCK_DIR=/var/lock/apache2 APACHE_PID_FILE=/var/run/apache2.pid

LABEL author="Gabriel ROGER"
ENV COMPOSER_ALLOW_SUPERUSER=1

# Expose port 80 (http) & 443 (https)
EXPOSE 443
EXPOSE 80

# Copy your files to working directory /var/www/html
COPY ./ /var/www/html
# Add read & write permission on workdir
RUN chmod -R 0755 /var/www/html
# Define working directory
WORKDIR /var/www/html

# git, unzip & zip are for composer
RUN apt-get update -qq && \
    apt-get install -qy \
    git \
    gnupg \
    unzip \
    zip \
    apt-utils \
    tzdata \
    apache2 \
    php7.4 \
    php-pear \
    php7.4-dev \
    php7.4-pdo-mysql \
    php7.4-xdebug \
    libapache2-mod-php && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PECL
# Create cache & log directory
RUN mkdir -p /tmp/pear/cache && \
    mkdir -p /var/www/html/log
RUN pecl channel-update pecl.php.net

# Copy php and xdebug configuration file to docker container
COPY conf/php.ini /etc/php/7.4/apache2/php.ini
COPY conf/xdebug.ini /etc/php/7.4/mods-available/xdebug.ini
COPY conf/xdebug_error.ini /etc/php/7.4/mods-available/xdebug_error.ini


# The xdebug distributed with Ubuntu 20.04 LTS is v2.9.2, we want v3.0.x
RUN pecl install xdebug
# Enable xdebug by default
RUN phpenmod xdebug

# Copy apache configuration file to docker container
COPY conf/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY conf/apache.conf /etc/apache2/conf-available/z-app.conf
COPY conf/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

# Commande to create ssl certificate with openssl
RUN openssl req -x509 -keyout /etc/ssl/private/localhost.pem -out /etc/ssl/certs/localhost.crt \
    -newkey rsa:2048 -nodes -sha256 -days 365 \
    -subj '/CN=localhost'

# Enable previously copied conf file
RUN a2enmod rewrite remoteip && \
    a2enmod ssl headers rewrite && \
    a2enconf z-app && \
    # Setup Apache2 HTTPS env
    a2enmod ssl && \
    a2ensite default-ssl.conf

# Update CA certificates
RUN update-ca-certificates

# start webserver
CMD /usr/sbin/apache2ctl -D FOREGROUND && \
    cd /var/www/html && php -d display_errors=1 -S 0.0.0.0:443 -t /var/www/html && \
    # restart apache & php
    systemctl restart php7.4 && \
    systemctl restart apache2