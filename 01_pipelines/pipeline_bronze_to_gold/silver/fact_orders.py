from pyspark.sql.functions import *
from pyspark.sql.types import * 
from pyspark import pipelines as dp 

@dp.table(name="fact_orders", table_properties={"quality": "silver"})
@dp.expect_all_or_drop (
    {
    "vaild_order_id_" :"order_id is not null",
    "vaild_order_timestamp" :"order_timestamp is not null" ,
    "vaild_order_customer_id" : "customer_id is not null",
    "vaild_order_restaurant_id" : "restaurant_id is not null",
    "vaild_item_count" : "item_count >0",
    "vaild_total_amount" : "total_amount > 0",
    "vaild_payment_method" : "payment_method in ('cash', 'card', 'wallet')",
    "vaild_order_status" : "order_status in ('completed', 'delivered', 'ready', 'pending', 'preparing','confirmed')"
    }
)
def fact_orders () :

    df_orders = (
        dp.read_stream("bcdbxproject.`01_bronze`.orders")
        .withColumn("order_timestamp", to_timestamp(col("order_timestamp")))
        .withColumn("order_date", to_date(col("order_timestamp")))
        .withColumn("order_hour", hour(col("order_timestamp")))
        .withColumn("day_of_week", date_format(col("order_timestamp"), "E"))
        .withColumn("item_count", size(col("items")))
        .withColumn("_ingestion_timestamp", current_timestamp())
        .select(
            col("order_id"),
            col("order_timestamp"),
            col("order_date"),
            col("order_hour"),
            col("day_of_week"),
            when(col("day_of_week").isin(["Sat", "Sun"]), True).otherwise(False).alias("is_weekend"),
            col("restaurant_id"),
            col("customer_id"),
            col("order_type"),
            col("item_count"),
            col("total_amount").cast("decimal(10,2)"),
            col("payment_method"),
            col("order_status")
        )
    )

    return df_orders