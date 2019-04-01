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
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-o", "LogLEvel=DEBUG"]
