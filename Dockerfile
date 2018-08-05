FROM alpine:edge

LABEL maintainer="TossPig <docker@TossP.com>" \
      version="2.0.1" \
      description="php5服务"

ENV TIMEZONE Asia/Shanghai

#RUN echo -e "http://mirrors.aliyun.com/alpine/edge/main/\nhttp://mirrors.aliyun.com/alpine/edge/community/" > /etc/apk/repositories
RUN apk update &&  apk upgrade && \ 
	apk add --no-cache tzdata logrotate && \
	apk add --no-cache --virtual php5_tools php5-fpm php5-cli \
			# php5-dev php5-pear php5-phar \
	        php5-zip \
			php5-xmlrpc \
			php5-sysvshm \
			php5-imap \
			php5-calendar \
			php5-soap \
			php5-shmop \
			php5-wddx \
			php5-suhosin \
			php5-bz2 \
			php5-sockets \
			php5-sysvmsg \
			php5-pspell \
			php5-iconv \
			php5-ftp \
			php5-gettext \
			php5-mssql \
			php5-mcrypt \
			php5-exif \
			php5-xmlreader \
			php5-gd \
			php5-xml \
			php5-pcntl \
			php5-apcu \
			php5-ctype \
			php5-intl \
			php5-openssl \
			php5-sysvsem \
			php5-posix \
			php5-dom \
			php5-curl \
			php5-xsl \
			php5-ldap \
			php5-json \
			php5-enchant \
			php5-bcmath \
			php5-opcache \
			php5-gmp \
			php5-snmp \
			php5-dba \			
			php5-sqlite3 php5-pgsql php5-mysql php5-mysqli \
			php5-pdo_sqlite php5-pdo_pgsql php5-pdo_mysql && \
	# 清理数据
	cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
	echo "${TIMEZONE}" > /etc/timezone && \
	mkdir -p /run/nginx && \
	apk del tzdata && \
	rm -rf /var/cache/apk/* && \
	

	echo '#!/bin/sh' > /ENTRYPOINT.sh  && \
	echo 'cp -rf /etc/php5/* /def_conf' >> /ENTRYPOINT.sh  && \
	echo '/usr/bin/php-fpm5 -t -y /conf/php-fpm.conf -c /conf/php.ini' >> /ENTRYPOINT.sh && \
	echo '/usr/bin/php-fpm5 -F -y /conf/php-fpm.conf -c /conf/php.ini' >> /ENTRYPOINT.sh && \
	chmod 755 /ENTRYPOINT.sh

VOLUME ["/log","/def_conf","/conf","/hosts"]

EXPOSE 9000

CMD ["/ENTRYPOINT.sh"]
