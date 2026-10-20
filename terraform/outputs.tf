output "uploads_bucket" {
  description = "Upload objects here to trigger processing"
  value       = aws_s3_bucket.uploads.id
}

output "queue_url" {
  description = "SQS queue URL"
  value       = aws_sqs_queue.queue.id
}

output "dynamodb_table" {
  description = "Table where object metadata is written"
  value       = aws_dynamodb_table.objects.name
}
