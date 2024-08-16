FROM rhel8/php-74

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 /opt/app-root/src/owncloud && \
    chmod -R g=u /opt/app-root/src/owncloud

COPY owncloud-httpd.conf /etc/httpd/conf.d/owncloud-httpd.conf

#Correr la instalación desde la CLI

# WORKDIR /opt/app-root/src/owncloud
USER 0
RUN sudo -u apache ./occ maintenance:install \
   --database "openshift" \
   --database-name "openshift" \
   --database-user "openshift"\
   --database-pass "openshift" \
   --admin-user "admin" \
   --admin-pass "admin"

# RUN sed -i 's/localhost/owncloud-openshift-git-or15.apps.ocpprod.pjedomex.gob.mx/g' config/config.php

# RUN chgrp -R 0 /opt/app-root/src/owncloud && \
#     chmod -R g=u /opt/app-root/src/owncloud

# RUN chmod -R 770 /opt/app-root/src/owncloud/data/files


EXPOSE 8080
CMD /usr/libexec/s2i/run