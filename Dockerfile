FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
openssh-server \
iputils-ping \
net-tools \
iproute2 \
dnsutils \
nmap \
rsync \
netcat \
curl \
telnet \
jq \
postgresql-client \
less \
pv \
git \
vim \
pwgen \
&& rm -rf /var/lib/apt/lists/*

ADD default-entrypoint.sh /default-entrypoint.sh
RUN chmod +x /default-entrypoint.sh 

EXPOSE 22
CMD ["/default-entrypoint.sh"]
