output "uploads_bucket" {
  value = module.pipeline.uploads_bucket
}
output "queue_url" {
  value = module.pipeline.queue_url
}
output "dynamodb_table" {
  value = module.pipeline.dynamodb_table
}
