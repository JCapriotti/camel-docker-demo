
#
# Base from https://github.com/dockerfile/java
# Copied RUN steps rather than just reusing the docker image because I couldn't get something to work. 
# This is not best practice.
#

FROM ubuntu:16.04


# Install.
RUN \
#  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
#  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
CMD ["bash"]

# This is the money code. Copy the JAR and run it. Stupid-easy.
RUN \
  mkdir /opt/data && \
  mkdir /opt/app && \
  # Easiest way to get JAR file was to download from a server (nike mount, in this case)
  wget --directory-prefix=/opt/app  http://172.25.124.34/devbox/hackathon-jcap/quotes-1.0.jar

CMD java -jar /opt/app/quotes-1.0.jar
