FROM ubi7/php-73

# Add application sources
ADD owncloud.tar.bz2 .

USER 0

RUN chgrp -R 0 . && \
    chmod -R g=u .

USER 1001

#RUN chown apache:apache -R .
#RUN chown apache:apache -R /opt/app-root/files

# Install the dependencies
#RUN TEMPFILE=$(mktemp) && \
#    curl -o "$TEMPFILE" "https://getcomposer.org/installer" && \
#    php <"$TEMPFILE" && \
#    ./composer.phar install --no-interaction --no-ansi --optimize-autoloader

# Run script uses standard ways to configure the PHP application
# and execs httpd -D FOREGROUND at the end
# See more in <version>/s2i/bin/run in this repository.
# Shortly what the run script does: The httpd daemon and php needs to be
# configured, so this script prepares the configuration based on the container
# parameters (e.g. available memory) and puts the configuration files into
# the approriate places.
# This can obviously be done differently, and in that case, the final CMD
# should be set to "CMD httpd -D FOREGROUND" instead.
EXPOSE 8080
CMD /usr/libexec/s2i/run