variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  default     = "s3-to-rds-glue-bucket"
}

variable "rds_username" {
  description = "Username for the RDS instance"
  default     = "admin"
}

variable "rds_password" {
  description = "Password for the RDS instance"
  default     = "admin"
}

variable "rds_db_name" {
  description = "Database name for the RDS instance"
  default     = "gdc-proj-database"
}
