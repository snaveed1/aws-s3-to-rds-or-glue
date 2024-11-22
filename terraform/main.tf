# S3 Bucket
resource "aws_s3_bucket" "data_bucket" {
  bucket = var.s3_bucket_name
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  db_name              = var.rds_db_name
  username             = var.rds_username
  password             = var.rds_password
  publicly_accessible  = true
  skip_final_snapshot  = true
}

# Glue Database
resource "aws_glue_catalog_database" "glue_database" {
  name = "s3_to_rds_glue_db"
}

# ECR Repository
resource "aws_ecr_repository" "ecr_repo" {
  name = "s3-to-rds-or-glue"
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name               = "lambda_exec_role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:*",
          "rds:*",
          "glue:*",
          "logs:*",
          "ecr:*"
        ],
        "Resource": "*"
      }
    ]
  }
EOF
}
