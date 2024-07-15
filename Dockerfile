FROM rhel8/php-74

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 . && \
    chmod -R g=u .

RUN mkdir /mnt/data

RUN chgrp -R 0 /mnt/data && \
    chmod -R g=u /mnt/data

COPY owncloud-httpd.conf /etc/httpd/conf.d/owncloud-httpd.conf

#Correr la instalación desde la CLI
WORKDIR /opt/app-root/src/owncloud
RUN ./occ maintenance:install \
   --database "mysql" \
   --database-host "ownclouddb" \
   --database-name "ownclouddb" \
   --database-user "ownclouddb"\
   --database-pass "ownclouddb" \
   --admin-user "admin" \
   --admin-pass "4dm1n1str4d0r."

USER 1001

EXPOSE 8080
CMD /usr/libexec/s2i/run