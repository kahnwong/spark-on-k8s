from pyspark.sql import SparkSession


if __name__ == "__main__":
    spark = SparkSession.builder.appName("PythonPi").getOrCreate()

    df = spark.createDataFrame(
        [
            (1, "foo"),  # create your data here, be consistent in the types.
            (2, "bar"),
        ],
        ["id", "label"],  # add your column names here
    )

    print(df.show())
    print(df.count())

    df.write.parquet("s3a://spark/output/df_parquet", mode="overwrite")

    spark.stop()
