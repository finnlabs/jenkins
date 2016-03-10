FROM jenkins
USER root
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN apt-get update && apt-get install apt-transport-https -y && apt-get clean
RUN echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install docker-engine -y && apt-get clean
RUN usermod -aG docker jenkins
# RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN apt-get update && \
	apt-get install -y expect patch bzip2 gawk g++ gcc make libc6-dev patch libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev && \
	apt-get install -y libmysqlclient-dev libpq-dev nodejs xvfb chromium && \
	apt-get clean

# Node
ENV NODE_VERSION="0.12.7"
RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | tar xzf - -C /usr/local --strip-components=1

# Make sure jenkins uses /var/lib/jenkins, not /var/jenkins_home
RUN usermod -d /var/lib/jenkins jenkins
VOLUME /var/lib/jenkins
# Base jenkins plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
