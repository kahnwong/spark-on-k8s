FROM spark:3.4.1

ENV SPARK_HOME=/opt/spark

WORKDIR /app
ADD examples examples
