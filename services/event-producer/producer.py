import json
import time
from datetime import datetime, timezone

from confluent_kafka import Producer

BOOTSTRAP_SERVERS = "localhost:9092"
TOPIC = "customer-events"


def delivery_report(err, msg):
    if err is not None:
        print(f"Delivery failed: {err}")
    else:
        print(f"Event delivered to {msg.topic()} " f"[partition {msg.partition()}]")

producer = Producer(
    {
        "bootstrap.servers": BOOTSTRAP_SERVERS
    }
)

events = [
    {
        "customer_id": "customer-1001",
        "event_type": "product_viewed",
        "product_id": "product-501"
    },
    {
        "customer_id": "customer-1001",
        "event_type": "added_to_cart",
        "product_id": "product-501"
    },
    {
        "customer_id": "customer-1002",
        "event_type": "checkout_completed",
        "order_id": "order-9001"
    }
]

for event in events:
    event["timestamp"] = datetime.now(timezone.utc).isoformat()

    producer.produce(
        topic=TOPIC,
        key=event["customer_id"],
        value=json.dumps(event),
        callback=delivery_report
    )

    producer.poll(0)
    time.sleep(1)

producer.flush()

print("Finished publishing customer events.")