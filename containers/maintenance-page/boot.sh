envsubst < /www/index.tpl > /www/index.html
rm /www/index.tpl

if [ "$USE_HSTS" -eq "1" ]; then
    sed -i 's/#add_header Strict-Transport-Security/add_header Strict-Transport-Security/' /etc/nginx/nginx.conf
fi


/usr/sbin/nginx -c /etc/nginx/nginx.conf

