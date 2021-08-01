#!/bin/bash

cp ../build/bin/echoNsServer echoNsServer/
cp ../build/bin/echoNsClient echoNsClient/

cd ns
podman build --format docker -t omninames:latest .
# podman build --format docker -t omninames:latest -t fir.love.io:3005/omninames:latest .
# podman push fir.love.io:3005/omninames:latest

cd echoNsServer
podman build --format docker -t echo-ns-server:latest .
# If tagging images and pushing to local docker registry
# podman build --format docker -t echo-ns-server:latest -t fir.love.io:3005/echo-ns-server:latest .
# podman push fir.love.io:3005/echo-ns-server:latest
cd ..

cd echoNsClient
podman build --format docker -t echo-ns-client:latest -t .
# If tagging images and pushing to local docker registry
# podman build --format docker -t echo-ns-client:latest -t fir.love.io:3005/echo-ns-client:latest .
# podman push fir.love.io:3005/echo-ns-client:latest
cd ..
