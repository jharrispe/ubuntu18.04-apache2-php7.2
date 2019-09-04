FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# update lists
RUN apt-get update

# apache, php, utils
RUN apt-get install -yq --no-install-recommends \
    apt-utils \
    apache2 \
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    openssl \
    vim \
    curl \
    git \
    imagemagick \
    mysql-client \
    iputils-ping \
    locales \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

RUN a2enmod rewrite expires
RUN echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf
RUN a2enconf servername
#RUN a2dissite 000-default

EXPOSE 80 443

WORKDIR /root

#RUN rm index.html

#HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost || exit 1

CMD apachectl -D FOREGROUND
