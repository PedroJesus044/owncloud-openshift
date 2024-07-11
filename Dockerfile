FROM rhel8/php-74

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 . && \
    chmod -R g=u .

RUN mkdir /mnt/data

RUN sudo yum install nfs-utils
RUN sudo mount -t nfs 10.10.0.10:/backups /var/backups

RUN chgrp -R 0 /mnt/data && \
    chmod -R g=u /mnt/data

USER 1001

EXPOSE 8080
CMD /usr/libexec/s2i/run