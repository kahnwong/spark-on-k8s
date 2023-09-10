import logging

import pyspark.sql.functions as F
from pyspark.sql import SparkSession

logger = logging.getLogger(__name__)
handler = logging.StreamHandler()

formatter = logging.Formatter("%(asctime)s - [%(levelname)s] - %(name)s - %(message)s")
handler.setFormatter(formatter)
logger.addHandler(handler)

logger.setLevel(logging.INFO)

if __name__ == "__main__":
    spark = SparkSession.builder.appName("PythonPi").getOrCreate()

    df = spark.read.parquet("s3a://spark/data/overturemaps/theme=buildings")
    logger.info(df.show())
    logger.info(f"count: {df.count()}")

    df = df.select("class", F.to_date("updatetime").alias("updatedate"))
    agg_cols = [
        "class",
        "updatedate",
    ]
    df_out = df.select(*agg_cols).groupBy(agg_cols).agg(F.count("*"))

    df_out.write.parquet("s3a://spark/output/df_parquet", mode="overwrite")

    spark.stop()
