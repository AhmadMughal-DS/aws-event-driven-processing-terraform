# AWS Event-Driven Processing Pipeline (Terraform)

> Decoupled, event-driven pipeline: S3 upload → SQS → Lambda → DynamoDB, with a dead-letter queue — provisioned with Terraform.
> **Author:** Muhammad Ahmad · **IaC:** Terraform · **Cloud:** AWS

![Terraform](https://img.shields.io/badge/Terraform-1.5%2B-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-S3%20%7C%20SQS%20%7C%20Lambda%20%7C%20DynamoDB-FF9900?logo=amazonaws&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📌 Overview

When a file lands in the S3 bucket, the pipeline reacts automatically:

1. **S3** emits an `ObjectCreated` event to an **SQS queue** (durable buffer).
2. **Lambda** consumes messages from the queue in batches.
3. It writes each object's metadata (key, bucket, size) to **DynamoDB**.
4. Messages that fail 5 times move to a **dead-letter queue** for inspection.

SQS decouples producer from consumer, absorbs spikes, and gives retries + DLQ for free.

## 🏗️ Architecture

```mermaid
flowchart LR
    Upload([File Upload])
    S3[(S3 Bucket)]
    Q[SQS Queue]
    DLQ[SQS Dead-Letter Queue]
    L[Lambda Processor]
    DDB[(DynamoDB)]

    Upload --> S3
    S3 -->|ObjectCreated event| Q
    Q -->|batch of 10| L
    L --> DDB
    Q -. after 5 failures .-> DLQ
```

## 🚀 Deploy & test

```bash
cd terraform
terraform init
terraform apply

# Upload a file to trigger the pipeline
aws s3 cp ./README.md s3://$(terraform output -raw uploads_bucket)/

# Check the stored metadata
aws dynamodb scan --table-name $(terraform output -raw dynamodb_table)
```

## 🧹 Clean up

```bash
terraform destroy
```

## 💰 Cost note

S3, SQS, Lambda, and on-demand DynamoDB are all pay-per-use — idle cost ≈ **$0**.

## 🔐 Production hardening (next steps)

- Add **S3 → EventBridge** for richer routing.
- Add **DLQ alarms** (CloudWatch) and a redrive runbook.
- Enable **SQS SSE** and bucket default encryption.

---

*Built and maintained by **Muhammad Ahmad**.*
