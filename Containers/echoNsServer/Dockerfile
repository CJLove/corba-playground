FROM fedora-minimal:34

ADD echoNsServer /

RUN \
    microdnf install -y omniORB && \
    echo "InitRef = NameService=corbaname::nameservice:2809" > /etc/omniORB.cfg && \
    echo "traceLevel = 10" >> /etc/omniORB.cfg && \
    echo "supportBootstrapAgen = 1" >> /etc/omniORB.cfg

CMD [ "/echoNsServer" ]
