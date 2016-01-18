FROM ubuntu:14.04

#
# variables
#

ENV KARAF_VERSION 4.0.3

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

#
# Set up Oracle Java 8
#

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y --force-yes oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Note: Curl is installed as well for install MAVEN.
#

#RUN apt-get install -y curl git

#
# Install Karaf
#

RUN wget http://repo1.maven.org/maven2/org/apache/karaf/apache-karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /tmp/karaf.tar.gz \
 && tar xzf /tmp/karaf.tar.gz -C /opt/ \
 && ln -s /opt/apache-karaf-${KARAF_VERSION} /opt/karaf \
 && rm /tmp/karaf.tar.gz

EXPOSE 8080 8181

CMD ["/opt/karaf/bin/karaf"]
