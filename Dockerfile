FROM 		ubuntu:14.04 
MAINTAINER 	denkhaus <peristaltic@gmx.net>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade && apt-get -y install unzip && apt-get clean

ADD build/docksul /bin/docksul
ADD https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego /bin/forego
RUN chmod +x /bin/forego

ADD https://dl.bintray.com/mitchellh/consul/0.3.0_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul

ADD https://dl.bintray.com/mitchellh/consul/0.3.0_web_ui.zip /tmp/consul_web_ui.zip
RUN mkdir /consul_web_ui && cd /consul_web_ui && unzip /tmp/consul_web_ui.zip

ADD Procfile Procfile
ADD ./config /config/
ONBUILD ADD ./config /config/

EXPOSE 8300 8301 8302 8400 8500 53/udp
VOLUME ["/data"]
ENTRYPOINT ["/bin/forego", "start", "-r"]
