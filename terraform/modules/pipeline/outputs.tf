output "uploads_bucket" {
  value = aws_s3_bucket.uploads.id
}
output "queue_url" {
  value = aws_sqs_queue.queue.id
}
output "dynamodb_table" {
  value = aws_dynamodb_table.objects.name
}
