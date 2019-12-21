FROM nginx:stable

RUN apt-get -y update; \
    apt-get -y install apt-transport-https wget gnupg
RUN wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add - ; \
    echo "deb https://apt.signalsciences.net/release/debian/ $(dpkg --status tzdata|grep Provides|cut -f2 -d'-') main" \
    >> /etc/apt/sources.list.d/sigsci-release.list; \
    apt-get -y update
RUN apt-get -y install sigsci-agent nginx-module-sigsci-nxo=$(nginx -v 2>&1 | cut -d/ -f 2)*

