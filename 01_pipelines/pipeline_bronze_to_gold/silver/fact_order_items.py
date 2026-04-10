from pyspark.sql.functions import *
from pyspark.sql.types import * 
from pyspark import pipelines as dp 

@dp.table(name="fact_order_items",table_properties={"quality": "silver"})
@dp.expect_all_or_drop(
    {
        "order_id": "order_id is NOT NULL",
        "order_timestamp": " order_timestamp is NOT NULL",
        "order_date": " order_date is NOT NULL",
        "restaurant_id": "restaurant_id is NOT NULL",
        "item_id": "item_id is NOT NULL",
        "item_name": "item_name is NOT NULL",
        "category": "category is NOT NULL",
        "quantity": "quantity > 0",
        "unit_price": "unit_price > 0",
        "subtotal": "subtotal > 0"
    }
)
def fact_order_items():

    df_fact_orders= (
        dp.read_stream("bcdbxproject.`01_bronze`.orders")
        .withColumn("order_timestamp", to_timestamp(col("order_timestamp")))
        .withColumn("order_date", to_date(col("order_timestamp")))
        .withColumn("item", explode("items"))
        .select(
            "order_id",
            "order_timestamp",
            "order_date",
            "restaurant_id",
            col("item.item_id").alias("item_id"),
            col("item.name").alias("item_name"),
            col("item.category"),
            col("item.quantity"),
            col("item.unit_price"),
            col("item.subtotal")
        )
    )

    return(df_fact_orders)