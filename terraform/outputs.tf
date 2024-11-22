output "s3_bucket_name" {
  value = aws_s3_bucket.data_bucket.bucket
}

output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "glue_database_name" {
  value = aws_glue_catalog_database.glue_database.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}
