# Используем базовый образ Alpine
FROM alpine:3.20.3

# Устанавливаем необходимые пакеты для сборки PHP и его расширений
RUN apk add --no-cache \
    build-base \
    autoconf \
    bison \
    re2c \
    libtool \
    linux-headers \
    openssl-dev \
    libxml2-dev \
    oniguruma-dev \
    curl-dev \
    libpng-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    zlib-dev \
    postgresql-dev \
    libmemcached-dev \
    redis \
    git \
    bash \
    curl \
    curl-dev \
    sqlite-dev \
    libapparmor-dev \
    bzip2-dev \
    gettext-dev \
    libxslt-dev \
    libzip-dev \
    imap-dev \
    c-client \
    mpdecimal \
    mpdecimal-dev \
    libxml2 \
    openssl \
    zlib \
    libpng \
    freetype \
    libjpeg-turbo \
    krb5-dev \
    libavif-dev \
    libwebp-dev \
    libxpm-dev \
    rabbitmq-c-dev

# Задаем версии PHP и его расширений
ENV PHP_VERSION 8.3.11
ENV IG_BINARY_VERSION 3.2.16
ENV XDEBUG_VERSION 3.3.0
ENV MEMCACHED_VERSION 3.2.0
ENV MEMCACHE_VERSION 8.2
ENV REDIS_VERSION 5.3.7
ENV DECIMAL_VERSION 1.5.0
ENV IMAP_VERSION 1.0.2
ENV RABBITMQ_VERSION 2.1.2

# Загружаем и собираем PHP из исходного кода
RUN curl -fsSL https://www.php.net/distributions/php-${PHP_VERSION}.tar.gz -o php.tar.gz && \
    tar -xzf php.tar.gz && \
    cd php-${PHP_VERSION} && \
    ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php \
    --with-libdir \
    --with-openssl \
    --with-openssl-dir \
    --enable-calendar \
    --enable-pcntl \
    --enable-gd \
    --enable-sockets \
    --enable-zip \
    --with-mysqli \
    --with-pdo-mysql \
    --with-pgsql \
    --with-pdo_pgsql \
    --enable-fpm \
    --with-fpm-acl \
    --with-fpm-apparmor \
    --with-fpm-selinux \
    --enable-opcache \
    --with-zlib-dir \
    --with-freetype \
    --enable-mbstring \
    --enable-soap \
    --with-curl \
    --with-zlib \
    --enable-gd \
    --enable-inline-optimization \
    --with-bz2 \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-pcntl \
    --enable-mbregex \
    --enable-exif \
    --enable-bcmath \
    --with-mhash \
    --with-zip \
    --with-jpeg \
    --with-png \
    --with-webp \
    --with-avif \
    --with-xpm \
    --with-fpm-user=wwwrun \
    --with-fpm-group=www \
    --enable-ftp \
    --with-gettext \
    --with-xmlrpc \
    --with-xsl \
    --enable-intl \
    --with-pear \
    --with-sqlite3 \
    && make && make install && \
    cp php.ini-production /usr/local/php/php.ini && \
    cd .. && rm -rf php-${PHP_VERSION} php.tar.gz

# Устанавливаем расширение igbinary
RUN curl -fsSL https://pecl.php.net/get/igbinary-${IG_BINARY_VERSION}.tgz -o igbinary.tgz && \
    tar -xzf igbinary.tgz && \
    cd igbinary-${IG_BINARY_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf igbinary-${IG_BINARY_VERSION} igbinary.tgz

# Устанавливаем Xdebug
RUN curl -fsSL https://pecl.php.net/get/xdebug-${XDEBUG_VERSION}.tgz -o xdebug.tgz && \
    tar -xzf xdebug.tgz && \
    cd xdebug-${XDEBUG_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf xdebug-${XDEBUG_VERSION} xdebug.tgz

# Устанавливаем Memcached
RUN curl -fsSL https://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz -o memcached.tgz && \
    tar -xzf memcached.tgz && \
    cd memcached-${MEMCACHED_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf memcached-${MEMCACHED_VERSION} memcached.tgz

# Устанавливаем Memcache
RUN curl -fsSL https://pecl.php.net/get/memcache-${MEMCACHE_VERSION}.tgz -o memcache.tgz && \
    tar -xzf memcache.tgz && \
    cd memcache-${MEMCACHE_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf memcache-${MEMCACHE_VERSION} memcache.tgz

# Устанавливаем Redis
RUN curl -fsSL https://pecl.php.net/get/redis-${REDIS_VERSION}.tgz -o redis.tgz && \
    tar -xzf redis.tgz && \
    cd redis-${REDIS_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf redis-${REDIS_VERSION} redis.tgz

# Устанавливаем Decimal
RUN curl -fsSL https://pecl.php.net/get/decimal-${DECIMAL_VERSION}.tgz -o decimal.tgz && \
    tar -xzf decimal.tgz && \
    cd decimal-${DECIMAL_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf decimal-${DECIMAL_VERSION} decimal.tgz

# Устанавливаем IMap
RUN curl -fsSL https://pecl.php.net/get/imap-${IMAP_VERSION}.tgz -o imap.tgz && \
    tar -xzf imap.tgz && \
    cd imap-${IMAP_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf imap-${IMAP_VERSION} imap.tgz


# Устанавливаем RabbitMQ
RUN curl -fsSL https://pecl.php.net/get/amqp-${RABBITMQ_VERSION}.tgz -o amqp.tgz && \
    tar -xzf amqp.tgz && \
    cd amqp-${RABBITMQ_VERSION} && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make && make install && \
    cd .. && rm -rf amqp-${RABBITMQ_VERSION} amqp.tgz

# Устанавливаем Ionube
RUN curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube_loaders.tar.gz && \
    tar -xzf ioncube_loaders.tar.gz && \
    cp ioncube/ioncube_loader_lin_8.3.so /usr/local/php/lib/php/extensions/no-debug-non-zts-20230831/ioncube_loader_lin_8.3.so && \
    echo "zend_extension=ioncube_loader_lin_8.3.so" >> /usr/local/php/php.ini && \
    rm -rf ioncube ioncube_loaders.tar.gz

# Биндинг
RUN ln /usr/local/php/bin/php /bin/php && \
    ln /usr/local/php/bin/phpize /bin/phpize && \
    ln /usr/local/php/bin/php-fpm /bin/php-fpm && \

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --filename=composer \
    --install-dir=/usr/local/bin && \
    echo "alias composer='composer'" >> /root/.bashrc


# Настраиваем рабочую директорию
WORKDIR /var/www/html

# Открываем порт 9000
EXPOSE 9000

# Запускаем PHP-FPM
CMD ["php-fpm", "-F"]

