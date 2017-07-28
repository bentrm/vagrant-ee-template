# Vagrant Java EE provisioning template

A simple provisioning template to run a PostgreSQL-backed Java EE application via Wildfly. Static clients can be served via nginx.

## Components

Provisioning of the following components is prepared and will happen in the listed order:

* Updated __Ubuntu 16.4 LTS__ (via bento/ubuntu-16.10)
* __Oracle Java 8__ (_you're silently accepting the Java license using this template!_)
* __PostgreSQL 9.5__
* __Wildfly 10.1.0__
* __nginx__
* ___Your app___...

Have a look at `variables.sh` to edit the provided default variables to your liking. You can add more values if needed.

## Ports

The VM is bound to an host-only network. The IP is static and is bound to `192.168.100.100`. The following components listen to `'*'` for ease of use.

|port|description|
|----|-----------|
|80|static web content served by __nginx__|
|5432|__PostgreSQL__ CLI interface|
|8080|__Wildfly__ http interface|
|9990|__Wildfly__ management interface|

## Files

|file|description|
|----|-----------|
|`app-install.sh`|Takes care of linking the content as needed, e.g. by adding a PostgreSQL-datasource to the Wildfly server, syncing static web content to the web servers root directory and deploying all globed WAR-files.
|`java-install.sh`|Installs __Oracle Java 8__ as the default JVM.|
|`nginx-install.sh`|Installs __nginx__ as provided by the Ubuntu software repositories.|
|`postgresql-install.sh`|Installs __PostgreSQL__ as provided by the Ubuntu software repositories.|
|`variables.sh`|Exports needed variables to execute the install scripts.|
|`wildfly-install.sh`|Downloads and installs __Wildfly 10__.|
|`wildfly.cli`|_`jboss-cli.sh`_-script that is used to add a __PostgreSQL__ XA-datasource programmatically. ENV variables are interpolated before executing the script with the CLI.

## Folders

Add your content here so it will be made available at provisioning time:

|folder|description|
|------|-----------|
|sites|`enabled-sites` configurations as used by __nginx__. A common use case would be to define a proxy location pointing to your Java application.|
|war|Self contained WAR-files (`*.war`) that will be deployed to the __Wildfly__ server at provisioning time.|
|www|Static web content as served by __nginx__.|

## Run

After adding your content and adjusting the settings to your needs run the VM via Vagrant.

```
$ vagrant up
```
