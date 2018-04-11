#!/bin/bash -xe

# adapted from https://github.com/GoogleCloudPlatform/terraform-google-lb-internal/blob/master/examples/simple/nginx_upstream.sh.tpl

apt-get update
apt-get install -y nginx

cat - > /etc/nginx/sites-available/upstream <<EOF
server {
    listen 80;
    location / {
        proxy_pass http://${UPSTREAM};
    }
}
EOF

unlink /etc/nginx/sites-enabled/default
ln -sf /etc/nginx/sites-available/upstream /etc/nginx/sites-enabled/upstream

systemctl enable nginx
systemctl reload nginx