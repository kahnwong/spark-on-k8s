FROM spark:3.4.1

ENV SPARK_HOME=/opt/spark

## Extra spark dependencies
ENV HADOOP_AWS_VERSION=3.3.4
ENV AWS_SDK_VERSION=1.12.262

USER root
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_VERSION}/hadoop-aws-${HADOOP_AWS_VERSION}.jar $SPARK_HOME/jars/
# ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-core/${AWS_SDK_VERSION}/aws-java-sdk-core-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-dynamodb/${AWS_SDK_VERSION}/aws-java-sdk-dynamodb-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/${AWS_SDK_VERSION}/aws-java-sdk-s3-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/${AWS_SDK_VERSION}/aws-java-sdk-${AWS_SDK_VERSION}.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/com/google/guava/guava/14.0.1/guava-14.0.1.jar $SPARK_HOME/jars/
ADD https://repo1.maven.org/maven2/net/java/dev/jets3t/jets3t/0.9.4/jets3t-0.9.4.jar $SPARK_HOME/jars/

RUN chmod 644 $SPARK_HOME/jars/*
USER spark

## App
WORKDIR /app
ADD examples examples
