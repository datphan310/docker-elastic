## Stage 0: Installs the current application on a Node Image.
FROM docker.elastic.co/elasticsearch/elasticsearch:6.6.0 as builder

WORKDIR /opt
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz"
RUN tar xzf jdk-8u201-linux-x64.tar.gz
RUN cd jdk1.8.0_201
RUN alternatives --install /usr/bin/java java /opt/jdk1.8.0_201/bin/java 2
RUN alternatives --config java

RUN alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_201/bin/jar 2
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_201/bin/javac 2
RUN alternatives --set jar /opt/jdk1.8.0_201/bin/jar
RUN alternatives --set javac /opt/jdk1.8.0_201/bin/javac
RUN export JAVA_HOME=/opt/jdk1.8.0_201
RUN export JRE_HOME=/opt/jdk1.8.0_201/jre
RUN export PATH=$PATH:/opt/jdk1.8.0_201/bin:/opt/jdk1.8.0_201/jre/bin

RUN cd /usr/local
COPY LicenseVerifier.java ./
COPY XPackBuild.java ./
RUN javac -cp "/usr/share/elasticsearch/lib/elasticsearch-6.6.0.jar:/usr/share/elasticsearch/lib/lucene-core-7.6.0.jar:/usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar" LicenseVerifier.java
RUN javac -cp "/usr/share/elasticsearch/lib/elasticsearch-6.6.0.jar:/usr/share/elasticsearch/lib/lucene-core-7.6.0.jar:/usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar:/usr/share/elasticsearch/lib/elasticsearch-core-6.6.0.jar"  XPackBuild.java

RUN mkdir tempJar
RUN cp /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar tempJar/
RUN cd tempJar
RUN jar -xf x-pack-core-6.6.0.jar
RUN mv org/elasticsearch/license/LicenseVerifier.class org/elasticsearch/license/LicenseVerifier.class.bak
RUN cp ../LicenseVerifier.class org/elasticsearch/license/
RUN mv org/elasticsearch/xpack/core/XPackBuild.class org/elasticsearch/xpack/core/XPackBuild.class.bak
RUN cp ../XPackBuild.class org/elasticsearch/xpack/core/
RUN rm x-pack-core-6.6.0.jar
RUN jar -cvf x-pack-core-6.6.0.jar *

RUN cp /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar /usr/share/elasticsearch/modules/x-pack-core/x-pack-core-6.6.0.jar.bak
RUN cp x-pack-core-6.6.0.jar /usr/share/elasticsearch/modules/x-pack-core/

CMD ["elasticsearch"]

EXPOSE 9200 9300


