FROM docker.io/library/alpine

RUN apk update \
    && apk add --no-cache nginx envsubst \
    && adduser -D -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www

COPY --chown=www:www ./static-html-directory /www
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./boot.sh /boot.sh

# Expose the port for access
EXPOSE 80/tcp

# Run the Nginx server
CMD ["/bin/sh","/boot.sh"]