FROM ubuntu:wily

RUN apt-get -y update

# install necessary packages
RUN apt-get -y install vim curl apt-utils software-properties-common

# install bitcoin repository
RUN apt-add-repository ppa:bitcoin/bitcoin

# install bitmark key and apt repository
RUN curl -s http://118.163.122.209:8192/apt/wily-sign.publickey | apt-key add -
RUN echo 'deb http://118.163.122.209:8192/apt wily main' > /etc/apt/sources.list.d/bitmark.list
RUN echo 'deb-src http://118.163.122.209:8192/apt wily main' >> /etc/apt/sources.list.d/bitmark.list

# install bitmarkd bitmark-cli bitmark-webgui
RUN apt-get -y update
RUN apt-get -y install bitcoind openjdk-8-jre jq bitmarkd bitmark-cli bitmark-webgui

# add bitcoind config
COPY bitcoin/bitcoin.conf /root/.bitcoin/bitcoin.conf

# create bitmark group and user
RUN addgroup bitmark
RUN adduser --home /home/bitmark \
              --gecos "Bitmark user" \
              --ingroup bitmark bitmark

# setup bitmarkd
COPY config/bitmarkd/ /etc/
RUN chown -R bitmarkd:bitmarkd /etc/bitmarkd-LOCAL.conf
RUN chown -R bitmarkd:bitmarkd /etc/bitmarkd-TESTING.conf
RUN chown -R bitmarkd:bitmarkd /etc/bitmarkd-BITMARK.conf

# setup bitmarkd for local chain
RUN mkdir /var/lib/bitmarkd/local
RUN bitmarkd --config-file=/etc/bitmarkd-LOCAL.conf generate-identity
RUN bitmarkd --config-file=/etc/bitmarkd-LOCAL.conf generate-rpc-cert
RUN bitmarkd --config-file=/etc/bitmarkd-LOCAL.conf generate-mine-cert

# setup bitmarkd for testing chain
RUN mkdir /var/lib/bitmarkd/testing
RUN bitmarkd --config-file=/etc/bitmarkd-TESTING.conf generate-identity
RUN bitmarkd --config-file=/etc/bitmarkd-TESTING.conf generate-rpc-cert
RUN bitmarkd --config-file=/etc/bitmarkd-TESTING.conf generate-mine-cert

# setup bitmarkd for bitmark chain
RUN mkdir /var/lib/bitmarkd/bitmark
RUN bitmarkd --config-file=/etc/bitmarkd-BITMARK.conf generate-identity
RUN bitmarkd --config-file=/etc/bitmarkd-BITMARK.conf generate-rpc-cert
RUN bitmarkd --config-file=/etc/bitmarkd-BITMARK.conf generate-mine-cert

# copy bitmarkWallet and modify owner
COPY bin /home/bitmark/bin/
COPY config/bitmark-pay /home/bitmark/config/bitmark-pay
RUN chown -R bitmark:bitmark /home/bitmark

# setup bitmark-webgui
RUN bitmark-webgui -c /etc/bitmark-webgui.conf setup -d /var/lib/bitmark-webgui
RUN chown -R bitmark:bitmark /etc/bitmark-webgui.conf
RUN chown -R bitmark:bitmark /var/lib/bitmark-webgui

WORKDIR /home/bitmark

EXPOSE 2160 2150 2140 2130
