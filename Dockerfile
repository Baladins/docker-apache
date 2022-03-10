FROM debian:bullseye

RUN apt-get update && apt-get -y install apache2 && apt-get clean
RUN dpkg -l | grep apache

RUN apt-get clean autoclean
RUN apt-get autoremove --yes
RUN rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /bin/ln -sf ../mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl

RUN usermod -u 1000 www-data

EXPOSE 80
EXPOSE 443

RUN a2enmod proxy
RUN a2enmod actions
RUN a2enmod rewrite
RUN a2enmod socache_shmcb
RUN a2enmod proxy_fcgi
RUN a2enmod headers
RUN a2enmod ext_filter

COPY apache2-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/apache2-foreground

CMD ["apache2-foreground"]
