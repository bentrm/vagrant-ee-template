#!/bin/bash

apt-get install -y nginx
rsync -avz /vagrant/sites/* /etc/nginx/sites-enabled
service nginx reload
