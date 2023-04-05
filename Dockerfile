FROM jrei/systemd-ubuntu:20.04

ARG VERSION
ENV container docker
RUN apt update && apt install -y apt-utils
RUN apt install -y \
    curl net-tools locales gzip \
    less wget sudo vim unzip
RUN apt install -y \
    default-jre

# Artifactory setup
RUN sh -c "mkdir -p /var/opt/jfrog"
WORKDIR /var/opt/jfrog
RUN sh -c "export JFROG_HOME=/var/opt/jfrog"
RUN sh -c "export ARTIFACTORY_HOME=${JFROG_HOME}/artifactory"
RUN sh -c "export JFROG_PRODUCT_HOME=${JFROG_HOME}/artifactory"
RUN sh -c "curl -L \
	'https://releases.jfrog.io/artifactory/artifactory-pro/org/artifactory/pro/jfrog-artifactory-pro/$VERSION/jfrog-artifactory-pro-$VERSION-linux.tar.gz' \
	-o jfrog-artifactory-pro-$VERSION-linux.tar.gz"
RUN sh -c "tar -zxf jfrog-artifactory-pro-$VERSION-linux.tar.gz"
RUN sh -c "rm -f jfrog-artifactory-pro-$VERSION-linux.tar.gz"
RUN sh -c "mv artifactory-pro-$VERSION artifactory"
RUN rm -f /var/opt/jfrog/artifactory/var/etc/system.yaml
COPY conf/system.yaml /var/opt/jfrog/artifactory/var/etc/
COPY conf/artifactory.system.properties /var/opt/jfrog/artifactory/var/etc/artifactory/
COPY lic/artifactory.lic /var/opt/jfrog/artifactory/var/etc/artifactory/
RUN mkdir -p /var/opt/jfrog/artifactory/var/backup/artifactory/baseline
COPY import/baseline.zip /var/opt/jfrog/artifactory/var/backup/artifactory/baseline/baseline.zip