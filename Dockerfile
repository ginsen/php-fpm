FROM php:8.2-fpm-buster

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    vim \
    curl \
    locales \
    iputils-ping \
    telnet \
    git \
    git-flow \
    unzip \
    zlib1g-dev \
    bash-completion \
    gnupg \
    libicu-dev \
    g++ \
    libyaml-dev \
    libbz2-dev \
    libc-client-dev \
    libcurl4-gnutls-dev \
    libedit-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libldap2-dev \
    libldb-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng-dev \
    libpq-dev \
    libsqlite3-dev \
    libssl-dev \
    libreadline-dev \
    libxslt1-dev \
    libzip-dev \
    memcached \
    ffmpeg \
    wget \
    unzip \
    zlib1g-dev \
    && docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gettext \
    mysqli \
    opcache \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    soap \
    sockets \
    xsl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install -j$(nproc) imap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure ldap \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-install pcntl \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis && docker-php-ext-enable redis \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    && pecl install yaml && docker-php-ext-enable yaml \
    && docker-php-source delete \
    && apt-get remove -y g++ wget \
    && apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

RUN apt-get update && apt-get install -y librabbitmq-dev && pecl install amqp
RUN docker-php-ext-enable amqp

RUN echo "date.timezone = \"${TIMEZONE}\"" > /usr/local/etc/php/conf.d/php-timezone.ini \
    && ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && echo "${LOCALE} UTF-8" > /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=${LOCALE}

RUN sed -i "s/;intl.default_locale =/intl.default_locale=${LANG}/g" /usr/local/etc/php/php.ini

# Setup pm.max.children
RUN sed -i -e "s/pm.max_children = 5/pm.max_children = 20/g" /usr/local/etc/php-fpm.d/www.conf
