FROM spark:3.4.1

ENV SPARK_HOME=/opt/spark

## Extra spark dependencies
ENV HADOOP_AWS_VERSION=3.3.4
ENV AWS_SDK_VERSION=1.12.262

USER root
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_VERSION}/hadoop-aws-${HADOOP_AWS_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
RUN chmod 644 $SPARK_HOME/jars/*
USER spark

## App
WORKDIR /app
ADD examples examples
