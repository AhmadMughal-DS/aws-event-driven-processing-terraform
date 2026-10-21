# Remote state backend (production). Bootstrap an S3 bucket (versioned + encrypted)
# and a DynamoDB lock table, then uncomment and run `terraform init -migrate-state`.
#
# terraform {
#   backend "s3" {
#     bucket         = "ahmad-tfstate-<account-id>"
#     key            = "aws-event-driven-processing-terraform/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "ahmad-tf-locks"
#     encrypt        = true
#   }
# }
