FROM rhel8/php-74

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 . && \
    chmod -R g=u .

RUN mkdir /mnt/data

RUN chgrp -R 0 /mnt/data && \
    chmod -R g=u /mnt/data

USER 1001

EXPOSE 8080
CMD /usr/libexec/s2i/run