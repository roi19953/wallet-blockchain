#!/usr/bin/env bash

# Maven Proxy Settings
if [ ! -z $HTTP_PROXY ] && [ -z $http_proxy ]; then http_proxy=$HTTP_PROXY; fi
if [ ! -z $HTTPS_PROXY ] && [ -z $https_proxy ]; then https_proxy=$HTTPS_PROXY; fi

if [ ! -z $http_proxy ]
then
    http_proxy_host=$(printf $http_proxy | sed 's|http.*://\(.*\):\(.*\)$|\1|')
    http_proxy_port=$(printf $http_proxy | sed 's|http.*://\(.*\):\(.*\)$|\2|')
    echo "Setting HTTP proxy to ($http_proxy_host, $http_proxy_port)"
fi
if [ ! -z $https_proxy ]
then
    https_proxy_host=$(printf $https_proxy | sed 's|http.*://\(.*\):\(.*\)$|\1|')
    https_proxy_port=$(printf $https_proxy | sed 's|http.*://\(.*\):\(.*\)$|\2|')
    echo "Setting HTTPS proxy to ($https_proxy_host, $https_proxy_port)"
fi

echo "Build Simplewallet java transaction processor.."
mvn clean install \
    -Dhttp.proxyHost=$http_proxy_host \
    -Dhttp.proxyPort=$http_proxy_port \
    -Dhttps.proxyHost=$https_proxy_host \
    -Dhttps.proxyPort=$https_proxy_port

java -cp target/javaprocessor-1.0-SNAPSHOT.jar main.java.simplewallet.processor.SimpleWalletProcessor tcp://validator:4004
