# Architecture Diagram — AWS Event-Driven Processing

## Lucid diagram

- **Master Lucid document (all 30 diagrams, icon style):** https://lucid.app/lucidchart/3da75ce3-ea66-4296-81b3-00d20a60435b/edit
- This project is **page 6** of that document.

## Lucid prompt (reusable)

```
Create an AWS architecture diagram titled "AWS Event-Driven Processing".
Left to right: a File Upload goes to an S3 Bucket; S3 emits an ObjectCreated event to
an SQS Queue; a Lambda Processor consumes batches from the queue and writes to a
DynamoDB table; failed messages after retries go to an SQS Dead-Letter Queue.
Label the arrows. Clean, professional AWS colors.
```

## Mermaid source

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
