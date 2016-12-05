# Keycloak 2.4.0.Final - docker and docker-compose

This is `docker-compose` setup for [Keycloak](http://www.keycloak.org/) server configured with [postgres database](https://www.postgresql.org/),  with [nginx https termination](https://www.nginx.com/) and [lightweight mail server](https://mailcatcher.me/).


## Used docker images

 * [keycloak-postgres, 2.4.0.Final](https://hub.docker.com/r/jboss/keycloak-postgres/)
 * [postgres, 9.5](https://hub.docker.com/_/postgres/)
 * [nginx configuration for https termination](https://github.com/anvilresearch/nginx), borrowed from anvilreserach and customized for Keycloak
 * [mailcatcher](https://hub.docker.com/r/schickling/mailcatcher/)

## Usage

 * Clone this repository and run `docker-compose up`
 * In separate shell, run `./add-cert-to-java-truststore.sh`. Fix script for your local java setup, idea is to put custom (self-signed) certificate into java `cacerts`
 * Add to your `/etc/hosts` file record for `identity.keycloak.tom` referencing `127.0.0.1`
   * `127.0.0.1	identity.keycloak.tom`


## Testing

 * point your browser to [https://identity.keycloak.tom](https://identity.keycloak.tom)
 * accept insecure site, or add ./keycloak-nginx/certs/identity.keycloak.tom.cert to browser's truststore

## Admin account
 * default admin account added to Keycloak is:
   * Username: **admin**
   * Password: **password**


### Modifications on Keycloak configuration

 * in `standalone.xml`, I've modified 2 lines:
   * line 410: ```<http-listener name="default" socket-binding="http" redirect-socket="https" proxy-address-forwarding="true"/>```
     * This modification tells Keycloak to pull the client’s IP address from the X-Forwarded-For header since it's behind nginx.
   * line 412: ```<host name="default-host" alias="localhost" default-web-module="keycloak-server.war">```
     * This modification deploys Keycloak as default application on root path (context)


### Tested on
 * `cat /etc/os-release`:
    ```
       NAME=Fedora
       VERSION="23 (Twenty Three)"
       ID=fedora
       VERSION_ID=23
       PRETTY_NAME="Fedora 23 (Twenty Three)"
       ANSI_COLOR="0;34"
       CPE_NAME="cpe:/o:fedoraproject:fedora:23"
       HOME_URL="https://fedoraproject.org/"
       BUG_REPORT_URL="https://bugzilla.redhat.com/"
       REDHAT_BUGZILLA_PRODUCT="Fedora"
       REDHAT_BUGZILLA_PRODUCT_VERSION=23
       REDHAT_SUPPORT_PRODUCT="Fedora"
       REDHAT_SUPPORT_PRODUCT_VERSION=23
       PRIVACY_POLICY_URL=https://fedoraproject.org/wiki/Legal:PrivacyPolicy
    ```
 * `uname -a`: Linux xxx.XXX 4.8.10-100.fc23.x86_64 #1 SMP Mon Nov 21 20:37:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
 * `docker --version`: Docker version 1.12.3, build 6b644ec
 * `docker-compose --version`: docker-compose version 1.8.1, build 878cff1

