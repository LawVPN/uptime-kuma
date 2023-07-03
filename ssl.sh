#!/bin/bash

echo "Not finished yet!"; sleep 10; exit 1

echo -e "Input your email: "; read email
echo -e "Input your domain or sub domain [make sure to turn off proxied if you are using cloudflare]: "; read domain

certbot certonly --standalone --agree-tos --email $email -d $domain

echo -e ""/etc/nginx/sites-available/default


sed -i 's/3001/443/' "/opt/uptime-kuma/server/server.js"
