FROM fedora-minimal:34

RUN \
    microdnf install -y omniORB-servers


CMD [ "omniNames", "-start", "-logdir", "/var/log/omniORB" ]
