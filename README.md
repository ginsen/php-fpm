# PHP-FPM Docker Image

This project is inspired in [nanoninja/php-fpm](https://github.com/nanoninja/php-fpm).

Docker container to install and run [PHP-FPM](https://php-fpm.org/).

## Supported branches and respective Dockerfile links

- master [Dockerfile](https://github.com/ginsen/php-fpm/blob/master/Dockerfile)
- 8.3 [Dockerfile](https://github.com/ginsen/php-fpm/blob/8.3/Dockerfile)
- 8.2 [Dockerfile](https://github.com/ginsen/php-fpm/blob/8.2/Dockerfile)
## What is PHP-FPM

PHP-FPM (FastCGI Process Manager) is an alternative FastCGI implementation for PHP.

## .env.dist to .env

```shell
cp .env.dist .env
```
And replace your locale and timezone attributes.

## Build image

This steep is no required, run this steep only if your required custom image 

```shell
docker build . --file Dockerfile --tag ginsen/php-fpm:8.2
```

## Getting image

Jump this steep if you build your custom image.
```sh
sudo docker image pull ginsen/php-fpm
```

## Running your PHP script

Run the PHP-FPM image, mounting a directory from your host.

```sh
sudo docker container run --rm -v $(pwd):/var/www/html ginsen/php-fpm php index.php
```

## Running as server

```sh
sudo docker container run --rm --name phpfpm -v $(pwd):/var/www/html -p 3000:3000 ginsen/php-fpm php -S="0.0.0.0:3000" -t="/var/www/html"
```

or using [Docker Compose](https://docs.docker.com/compose/) :

```sh
version: '3'
services:
  phpfpm:
    container_name: phpfpm
    image: ginsen/php-fpm
    ports:
      - 3000:3000
    environment:
      - TIMEZONE=${TIMEZONE}
      - LOCALE=${LOCALE}
      - LANG=${LANG}
    volumes:
      - /path/to/your/app:/var/www/html
    command: php -S="0.0.0.0:3000" -t="/var/www/html"
```

### Logging

```sh
sudo docker container logs phpfpm
```

## Installed extensions

```bash
sudo docker container run --rm ginsen/php-fpm php -m
```

### PHP Modules

- bcmath
- bz2
- calendar
- Core
- ctype
- curl
- date
- dom
- exif
- fileinfo
- filter
- ftp
- gd
- gettext
- hash
- iconv
- imagick
- imap
- intl
- json
- ldap
- libxml
- mbstring
- memcached
- mongodb
- mysqli
- mysqlnd
- openssl
- pcre
- PDO
- pdo_mysql
- pdo_pgsql
- pdo_sqlite
- pgsql
- Phar
- posix
- readline
- redis
- Reflection
- session
- SimpleXML
- soap
- sockets
- sodium
- SPL
- sqlite3
- standard
- tokenizer
- xdebug
- xml
- xmlreader
- xmlrpc
- xmlwriter
- xsl
- Zend OPcache
- zip
- zlib

### Zend Modules

- Xdebug
- Zend OPcache