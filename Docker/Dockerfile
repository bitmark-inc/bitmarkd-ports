FROM ubuntu:wily

RUN apt-get -y update

# install necessary packages
RUN apt-get -y install vim curl apt-utils

# install bitmark key and apt repository
RUN curl -s http://118.163.122.209:8192/apt/wily-sign.publickey | apt-key add -
RUN echo 'deb http://118.163.122.209:8192/apt wily main' > /etc/apt/sources.list.d/bitmark.list
RUN echo 'deb-src http://118.163.122.209:8192/apt wily main' >> /etc/apt/sources.list.d/bitmark.list

# install bitmarkd bitmark-cli bitmark-webgui
RUN apt-get -y update
RUN apt-get -y install openjdk-8-jre jq bitmarkd bitmark-cli bitmark-webgui

# create bitmark group and user
RUN addgroup bitmark
RUN adduser --home /home/bitmark \
              --gecos "Bitmark user" \
              --ingroup bitmark bitmark

# setup bitmarkd
RUN bitmarkd --config-file=/etc/bitmarkd.conf generate-identity
RUN bitmarkd --config-file=/etc/bitmarkd.conf generate-rpc-cert
RUN bitmarkd --config-file=/etc/bitmarkd.conf generate-mine-cert

# copy bitmarkWallet and modify owner
COPY bin /home/bitmark/bin/
COPY config /home/bitmark/config/
RUN chown -R bitmark:bitmark /home/bitmark

# setup bitmark-webgui
RUN bitmark-webgui -c /etc/bitmark-webgui.conf setup -d /var/lib/bitmark-webgui
RUN chown -R bitmark:bitmark /etc/bitmark-webgui.conf
RUN chown -R bitmark:bitmark /var/lib/bitmark-webgui

WORKDIR /home/bitmark

EXPOSE 2150 2140
