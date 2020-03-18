#!/bin/sh
docker run -it --rm --name certbot -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -p 80:80 -p 443:443 \
certbot/certbot certonly --standalone -d $1 --keep-until-expiring

cat /etc/letsencrypt/live/$1/cert.pem /etc/letsencrypt/live/$1/privkey.pem > /etc/cockpit/ws-certs.d/1-cert.cert
systemctl restart cockpit.service


cp /etc/letsencrypt/live/$1/privkey.pem /tmp/
cp /etc/letsencrypt/live/$1/fullchain.pem /tmp/
docker cp /tmp/privkey.pem nginx-reverse_nginx_1:/etc/nginx/
docker cp /tmp/fullchain.pem nginx-reverse_nginx_1:/etc/nginx/
rm /tmp/privkey.pem
rm /tmp/fullchain.pem
