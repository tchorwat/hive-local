FROM ubuntu:focal as base
LABEL maintainer="tomasz@chorwat.pl"
LABEL project="https://github.com/tchorwat/hive"

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    gosu \
    nano \
    openjdk-8-jdk \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/*

ENV HADOOP_HOME="/hadoop/hadoop-2.10.1"
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# Copy projects scripts
RUN mkdir /hadoop \
  && cd /hadoop \
  && wget https://downloads.apache.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz \
  && tar -xf hadoop-2.10.1.tar.gz \
  && rm hadoop-2.10.1.tar.gz

ENV HIVE_HOME="/hive/apache-hive-1.2.2-bin"
# Copy projects scripts
RUN mkdir /hive \
  && mkdir /data \
  && cd /hive \
  && wget https://downloads.apache.org/hive/hive-1.2.2/apache-hive-1.2.2-bin.tar.gz \
  && tar -xf apache-hive-1.2.2-bin.tar.gz \
  && ln -s /hive/apache-hive-1.2.2-bin/conf/ /hive/conf \
  && rm apache-hive-1.2.2-bin.tar.gz

COPY ./hive-site.xml /hive/conf/

COPY ./entrypoint.sh /root/
RUN chmod +x /root/entrypoint.sh

WORKDIR /hive
USER root
EXPOSE 10000/tcp
ENV PATH="/hive/apache-hive-1.2.2-bin/bin:${PATH}"
ENTRYPOINT ["/root/entrypoint.sh"]
