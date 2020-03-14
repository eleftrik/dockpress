FROM php:7.3-fpm

# If XDebug has been enabled, configure it
ARG ENABLE_XDEBUG
RUN if [ ${ENABLE_XDEBUG} = 1 ] ; then \
    pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.default_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey='PHPSTORM'" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable_trigger=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_dir='/opt/profile'" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && docker-php-ext-enable xdebug ;\
fi;

#    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
#    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
#    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl \
    libmemcached-dev \
    libz-dev \
    libjpeg-dev \
    libpng-dev \
    libssl-dev \
    libmcrypt-dev \
    nano \
    vim \
    cron \
    git \
    unzip \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli
RUN docker-php-ext-install pdo_mysql \
    pcntl \
    zip
RUN pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis
RUN docker-php-ext-configure gd -with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# Configure php.ini
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN sed -e 's/max_execution_time = 30/max_execution_time = 600/' -i "$PHP_INI_DIR/php.ini"
RUN sed -e 's/memory_limit = 128M/memory_limit = 512M/' -i "$PHP_INI_DIR/php.ini"

# Install wp-cli globally
RUN cd /tmp && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Add www user and www group
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Change current user to www
USER www
