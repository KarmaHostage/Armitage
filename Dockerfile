FROM linuxkonsult/kali
MAINTAINER Quinten De Swaef "info@de-swaef.eu"
RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade && apt-get install sudo ruby metasploit-framework openjdk-8-jre -y && apt-get clean autoclean && rm -rf /var/lib/apt
ADD config/database.yml /usr/share/metasploit-framework/config/database.yml
RUN wget 'http://www.fastandeasyhacking.com/download/armitage-latest.tgz' -O- | tar zxvf - && mv /armitage /opt/. \
      && ln -s /opt/armitage/armitage /usr/local/bin/armitage  \
      && ln -s /opt/armitage/teamserver /usr/local/bin/teamserver \
      && /bin/sh -c "echo java -jar /opt/armitage/armitage.jar \$\* > /opt/armitage/armitage" \
      && perl -pi -e 's/armitage.jar/\/opt\/armitage\/armitage.jar/g' /opt/armitage/teamserver
ENV MSF_DATABASE_CONFIG /usr/share/metasploit-framework/config/database.yml
ENV ARMITAGE_PASSWORD K4rmaH0stage
VOLUME /scripts
EXPOSE 80 4444 8080 55553 55554
ADD initialize.sh /initialize.sh
ENTRYPOINT ["./initialize.sh"]
