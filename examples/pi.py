from pyspark.sql import SparkSession


if __name__ == "__main__":
    spark = SparkSession.builder.appName("PythonPi").getOrCreate()

    df = spark.read.parquet("s3a://bucket/file.parquet")  # change me

    print(df.show())
    print(df.count())

    df.write.parquet("s3a://bucket/output/df_parquet", mode="overwrite")

    spark.stop()
