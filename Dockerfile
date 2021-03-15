FROM composer:2 as composerBuilder
FROM caddy:2 as caddyBuilder

FROM php:8.0-fpm-buster
WORKDIR /var/www
COPY --from=composerBuilder /usr/bin/composer /usr/bin/composer
COPY --from=caddyBuilder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile ./Caddyfile
COPY EntryPoint /usr/local/bin/EntryPoint
RUN apt-get update
RUN apt-get install -y git libxml2-dev libzip-dev
RUN docker-php-ext-install xml
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install zip
CMD ["EntryPoint"]
EXPOSE 80
