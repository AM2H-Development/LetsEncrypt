#!/bin/sh
docker run -t --rm --name certbot -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" -p 80:80 -p 443:443 \
certbot/certbot certonly --standalone -d $1 --keep-until-expiring > /var/log/letsencrypt.log

cat /etc/letsencrypt/live/$1/cert.pem /etc/letsencrypt/live/$1/privkey.pem > /etc/cockpit/ws-certs.d/1-cert.cert

cp /etc/letsencrypt/live/$1/privkey.pem /var/certs/
cp /etc/letsencrypt/live/$1/fullchain.pem /var/certs/
cp /etc/letsencrypt/live/$1/cert.pem /var/certs/

docker cp /var/certs/privkey.pem influx_influxdb_reverse:/etc/nginx/
docker cp /var/certs/fullchain.pem influx_influxdb_reverse:/etc/nginx/

docker cp /var/certs/privkey.pem influx_grafana_reverse:/etc/nginx/
docker cp /var/certs/fullchain.pem influx_grafana_reverse:/etc/nginx/

systemctl restart cockpit.service
docker restart influx_influxdb_reverse
docker restart influx_grafana_reverse
