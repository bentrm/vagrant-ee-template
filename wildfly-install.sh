#!/bin/bash

# skipping download under development
file="/vagrant/$WILDFLY_ARCHIVE_NAME"
if [ -f "$file" ]
then
	echo "$file found locally, using the file.."
	cp $file /home/vagrant/$WILDFLY_ARCHIVE_NAME
fi

echo "Downloading: $WILDFLY_DOWNLOAD_ADDRESS..."
[ -e "$WILDFLY_ARCHIVE_NAME" ] && echo 'Wildfly archive already exists.'
if [ ! -e "$WILDFLY_ARCHIVE_NAME" ]; then
  wget -q $WILDFLY_DOWNLOAD_ADDRESS
  if [ $? -ne 0 ]; then
    echo "Not possible to download Wildfly."
    exit 1
  fi
fi

echo "Cleaning up..."
rm -f "$WILDFLY_DIR"
rm -rf "$WILDFLY_FULL_DIR"
rm -rf "/var/run/$WILDFLY_SERVICE/"
rm -f "/etc/init.d/$WILDFLY_SERVICE"

echo "Installation..."
mkdir $WILDFLY_FULL_DIR
tar -xzf $WILDFLY_ARCHIVE_NAME -C $INSTALL_DIR
ln -s $WILDFLY_FULL_DIR/ $WILDFLY_DIR
useradd -s /sbin/nologin $WILDFLY_USER
chown -R $WILDFLY_USER:$WILDFLY_USER $WILDFLY_DIR
chown -R $WILDFLY_USER:$WILDFLY_USER $WILDFLY_DIR/

echo "Registrating Wildfly as service..."
cp $WILDFLY_DIR/docs/contrib/scripts/init.d/wildfly-init-debian.sh /etc/init.d/$WILDFLY_SERVICE
sed -i -e 's,NAME=wildfly,NAME='$WILDFLY_SERVICE',g' /etc/init.d/$WILDFLY_SERVICE
sed -i -e 's,JBOSS_CONFIG=standalone.xml,JBOSS_CONFIG='$WIDLFLY_DEFAULT_CONFIG',g' /etc/init.d/$WILDFLY_SERVICE
WILDFLY_SERVICE_CONF=/etc/default/$WILDFLY_SERVICE
chmod 755 /etc/init.d/$WILDFLY_SERVICE
sudo update-rc.d $WILDFLY_SERVICE defaults

echo "Configuring service..."
echo JBOSS_HOME=\"$WILDFLY_DIR\" > $WILDFLY_SERVICE_CONF
echo JBOSS_USER=$WILDFLY_USER >> $WILDFLY_SERVICE_CONF
echo JBOSS_OPTS=\"-b 0.0.0.0 -bmanagement 0.0.0.0\" >>$WILDFLY_SERVICE_CONF
echo STARTUP_WAIT=$WILDFLY_STARTUP_TIMEOUT >> $WILDFLY_SERVICE_CONF
echo SHUTDOWN_WAIT=$WILDFLY_SHUTDOWN_TIMEOUT >> $WILDFLY_SERVICE_CONF

service $WILDFLY_SERVICE start

echo "Done."
