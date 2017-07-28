#!/bin/bash

# Download PostgreSQL JDBC Driver
# skipping download under development
file="/vagrant/$PG_DRIVER_FILENAME"
if [ -f "$file" ]
then
	echo "$file found locally, using the file.."
	cp $file /home/vagrant/$PG_DRIVER_FILENAME
fi

echo "Downloading: $PG_DRIVER_DOWNLOAD_ADDRESS..."
if [ ! -e "$PG_DRIVER_FILENAME" ]; then
  wget -q $PG_DRIVER_DOWNLOAD_ADDRESS
  if [ $? -ne 0 ]; then
    echo "Not possible to download PostgreSQL JDBC Driver."
    exit 1
  fi
fi

# Add VIP Wildfly user
$WILDFLY_DIR/bin/add-user.sh --user $APP_DB_USER --password $APP_DB_PASS

# Install DS
cat /vagrant/wildfly.cli | envsubst > /home/vagrant/wildfly-env.cli
$WILDFLY_DIR/bin/jboss-cli.sh --file=/home/vagrant/wildfly-env.cli

# Deploy WARs
for filename in /vagrant/war/*.war; do
  /opt/wildfly/bin/jboss-cli.sh -c --command="deploy $filename"
done

# Sync static web content
mkdir -p $WWW_CONTENT
rsync -avz /vagrant/www/* $WWW_CONTENT
