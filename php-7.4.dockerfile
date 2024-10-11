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
    zlib \
    libpng \
    freetype \
    libjpeg-turbo \
    krb5-dev \
    libavif-dev \
    libwebp-dev \
    libxpm-dev \
    rabbitmq-c-dev \
    libacl \
    acl-dev

COPY src/php-extensions-install /usr/local/bin/php-extensions-install


# Задаем версии PHP и его расширений
ENV PHP_VERSION 7.4.33
ENV IG_BINARY_VERSION 3.2.16
ENV XDEBUG_VERSION 2.9.8
ENV MEMCACHED_VERSION 3.2.0
ENV MEMCACHE_VERSION 8.2
ENV REDIS_VERSION 5.3.7
ENV DECIMAL_VERSION 1.5.0
ENV IMAP_VERSION 2007f
ENV OPENSSL_VERSION 1.1.1u
ENV RABBITMQ_VERSION 2.1.2
ENV MONGODB_VERSION 1.20.0

RUN curl -fsSL http://ftp.ntua.gr/pub/net/mail/imap/imap-${IMAP_VERSION}.tar.gz -o imap-${IMAP_VERSION}.tar.gz && \
   tar -xzf imap-${IMAP_VERSION}.tar.gz && \
   cd imap-${IMAP_VERSION} && \
   yes "y" | make -j1 slx SPECIALAUTHENTICATORS=ssl SSLTYPE=none IP6=4 SSLINCLUDE=/usr/include/openssl && \
   mkdir /usr/include/imap -p && \
   cp src/c-client/*.h /usr/include/imap && \
   cd .. && rm -rf imap-${IMAP_VERSION} imap-${IMAP_VERSION}.tar.gz

RUN curl -fsSL https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1u/openssl-${OPENSSL_VERSION}.tar.gz -o openssl-${OPENSSL_VERSION}.tar.gz && \
    tar -xzf openssl-${OPENSSL_VERSION}.tar.gz && \
    cd openssl-${OPENSSL_VERSION} && \
    ./config && \
    make && make install && \
    cd .. && rm -rf openssl-${OPENSSL_VERSION} openssl-${OPENSSL_VERSION}.tar.gz

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
    --with-imap-ssl \
    --with-kerberos \
    && make && make install && \
    cp php.ini-production /usr/local/php/php.ini && \
    cd .. && rm -rf php-${PHP_VERSION} php.tar.gz

RUN php-extensions-install igbinary-${IG_BINARY_VERSION}
RUN php-extensions-install xdebug-${XDEBUG_VERSION}
RUN php-extensions-install memcached-${MEMCACHED_VERSION}
RUN php-extensions-install memcache-${MEMCACHE_VERSION}
RUN php-extensions-install redis-${REDIS_VERSION}
RUN php-extensions-install decimal-${DECIMAL_VERSION}
RUN php-extensions-install amqp-${RABBITMQ_VERSION}
RUN php-extensions-install mongodb-${MONGODB_VERSION}

# Устанавливаем Ionube
RUN curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube_loaders.tar.gz && \
    tar -xzf ioncube_loaders.tar.gz && \
    EXT_DIR=$(ls  /usr/local/php/lib/php/extensions) && \
    cp ioncube/ioncube_loader_lin_7.4.so /usr/local/php/lib/php/extensions/$EXT_DIR/ioncube_loader_lin_7.4.so && \
    echo "zend_extension=ioncube_loader_lin_7.4.so" >> /usr/local/php/php.ini && \
    rm -rf ioncube ioncube_loaders.tar.gz

# Биндинг
RUN ln /usr/local/php/bin/php /bin/php && \
    ln /usr/local/php/bin/phpize /bin/phpize && \
    ln /usr/local/php/sbin/php-fpm /sbin/php-fpm && \

# # Composer
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

