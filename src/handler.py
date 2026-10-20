import json
import os

import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])


def handler(event, context):
    """Triggered by SQS. Each message is an S3 event; store object metadata."""
    processed = 0
    for record in event.get("Records", []):
        body = json.loads(record["body"])
        for s3_record in body.get("Records", []):
            s3 = s3_record.get("s3", {})
            key = s3.get("object", {}).get("key")
            if not key:
                continue
            table.put_item(
                Item={
                    "key": key,
                    "bucket": s3.get("bucket", {}).get("name", ""),
                    "size": s3.get("object", {}).get("size", 0),
                    "event": s3_record.get("eventName", ""),
                }
            )
            processed += 1
    return {"processed": processed}
