FROM rhel8/php-74

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 /opt/app-root/src/owncloud && \
    chmod -R g=u /opt/app-root/src/owncloud

COPY owncloud-httpd.conf /etc/httpd/conf.d/owncloud-httpd.conf

#Correr la instalación desde la CLI

# WORKDIR /opt/app-root/src/owncloud
# RUN ./occ maintenance:install \
#    --database "mysql" \
#    --database-host "mariadbocbuilder" \
#    --database-name "mariadbocbuilder" \
#    --database-user "mariadbocbuilder"\
#    --database-pass "mariadbocbuilder" \
#    --admin-user "admin" \
#    --admin-pass "4dm1n1str4d0r."

# RUN sed -i 's/localhost/owncloud-openshift-git-or15.apps.ocpprod.pjedomex.gob.mx/g' config/config.php

# RUN chgrp -R 0 /opt/app-root/src/owncloud && \
#     chmod -R g=u /opt/app-root/src/owncloud

# RUN chmod -R 770 /opt/app-root/src/owncloud/data/files
RUN mkdir -p /opt/app-root/src/owncloud/data/files

RUN usermod -a -G apache root

EXPOSE 8080
USER apache
CMD /usr/libexec/s2i/run
