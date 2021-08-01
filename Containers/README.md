# Containerized OmniORB Corba apps

This directory defines Docker images and a Docker Compose manifest for running the
OmniORB nameserver and simple echo client/server containers.  This runs on Fedora 34 using rootless podman/docker-compose.

## Images
1. `omninames` - omniORB nameserver
2. `echo-ns-client` - echo client app which uses nameserver to resolve servant reference
3. `echo-ns-server` - echo server app which uses nameserver to register servant

Of note is that the client and server images configure omniORB (`/etc/omniorb.cfg`) with `NameService=corbaname::nameservice:2809`, where `nameservice` is the name of the nameserver service in the Docker Compose manifest

## Manifest
All services share the `corba` network.  Services:

- `nameservice` - uses the omninames image
- `echo-client` - uses the echo-ns-client image
- `echo-server` - uses the echo-ns-server image

