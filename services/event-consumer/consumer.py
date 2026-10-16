import json

from confluent_kafka import Consumer


BOOTSTRAP_SERVERS = "localhost:9092"
TOPIC = "customer-events"
GROUP_ID = "customer-event-processor"


consumer = Consumer(
    {
        "bootstrap.servers": BOOTSTRAP_SERVERS,
        "group.id": GROUP_ID,
        "auto.offset.reset": "earliest"
    }
)

consumer.subscribe([TOPIC])

print("Listening for customer events... Press Ctrl+C to stop.")

try:
    while True:
        message = consumer.poll(1.0)

        if message is None:
            continue

        if message.error():
            print(f"Consumer error: {message.error()}")
            continue

        raw_value = message.value().decode("utf-8")

        try:
            event = json.loads(raw_value)

            print(
                f"Received {event['event_type']} "
                f"for {event['customer_id']} "
                f"[partition {message.partition()}, "
                f"offset {message.offset()}]"
            )

        except json.JSONDecodeError:
            print(f"Skipping non-JSON record: {raw_value}")

except KeyboardInterrupt:
    print("\nStopping consumer...")

finally:
    consumer.close()