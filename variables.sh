#!/bin/bash

## App settings
export APP_DB_USER=vagrant
export APP_DB_PASS=vagrant
export APP_DB_NAME=$APP_DB_USER
export APP_DB_IMPORT_SCRIPT=import.sql

## PostgreSQL settings
export PG_VERSION=9.5
export PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
export PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
export PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

## PostgreSQL JDBC Driver settings
export PG_DRIVER_VERSION=42.1.3
export PG_DRIVER_FILENAME=postgresql-$PG_DRIVER_VERSION.jar
export PG_DRIVER_DOWNLOAD_ADDRESS=https://jdbc.postgresql.org/download/$PG_DRIVER_FILENAME

## WIDLFLY SETTINGS
export WIDLFLY_DEFAULT_CONFIG="standalone.xml"
export WILDFLY_VERSION=10.1.0.Final
export WILDFLY_FILENAME=wildfly-$WILDFLY_VERSION
export WILDFLY_ARCHIVE_NAME=$WILDFLY_FILENAME.tar.gz
export WILDFLY_DOWNLOAD_ADDRESS=http://download.jboss.org/wildfly/$WILDFLY_VERSION/$WILDFLY_ARCHIVE_NAME
export WILDFLY_DS_JNDI_NAME=java:jboss/datasources/vip-process-engine

export INSTALL_DIR=/opt
export WILDFLY_FULL_DIR=$INSTALL_DIR/$WILDFLY_FILENAME
export WILDFLY_DIR=$INSTALL_DIR/wildfly

export WILDFLY_USER="wildfly"
export WILDFLY_SERVICE="wildfly"

export WILDFLY_STARTUP_TIMEOUT=240
export WILDFLY_SHUTDOWN_TIMEOUT=30

export WWW_CONTENT=/srv/www/html
