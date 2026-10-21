locals {
  name_prefix = var.project_name
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/../src"
  output_path = "${path.module}/build/processor.zip"
}

module "pipeline" {
  source          = "./modules/pipeline"
  name_prefix     = local.name_prefix
  environment     = var.environment
  lambda_zip_path = data.archive_file.lambda.output_path
  lambda_zip_hash = data.archive_file.lambda.output_base64sha256
}
