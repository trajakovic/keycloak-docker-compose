#!/usr/bin/env bash
JAVA_JDK=${JAVA_HOME:-/usr/java/default}
echo "Java path: ${JAVA_JDK}"

sudo ${JAVA_JDK}/jre/bin/keytool \
    -import -trustcacerts \
    -alias "identity.keycloak.tom" -file ./keycloak-nginx/certs/identity.keycloak.tom.cert \
    -keystore ${JAVA_JDK}/jre/lib/security/cacerts \
    -storepass changeit \
    -noprompt
