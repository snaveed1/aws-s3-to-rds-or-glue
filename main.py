import boto3
import pymysql
from botocore.exceptions import ClientError

# AWS Clients
s3_client = boto3.client('s3')
rds_client = boto3.client('rds')
glue_client = boto3.client('glue')

# RDS Connection Configuration
RDS_HOST = "your-rds-host"
RDS_PORT = 3306
RDS_USER = "your-username"
RDS_PASS = "your-password"
RDS_DB = "your-database"

# S3 Configuration
S3_BUCKET = "your-s3-bucket-name"
S3_FILE_KEY = "path/to/your/file.csv"

# Glue Database
GLUE_DATABASE = "your-glue-database"

def read_from_s3():
    try:
        response = s3_client.get_object(Bucket=S3_BUCKET, Key=S3_FILE_KEY)
        data = response['Body'].read().decode('utf-8')
        return data.splitlines()
    except ClientError as e:
        print(f"Error reading from S3: {e}")
        return None

def write_to_rds(data):
    try:
        connection = pymysql.connect(
            host=RDS_HOST,
            user=RDS_USER,
            password=RDS_PASS,
            database=RDS_DB,
            port=RDS_PORT
        )
        with connection.cursor() as cursor:
            for line in data:
                # Assuming data is comma-separated
                columns = line.split(',')
                cursor.execute("INSERT INTO your_table (col1, col2, col3) VALUES (%s, %s, %s)", columns)
            connection.commit()
        print("Data inserted into RDS successfully.")
        return True
    except Exception as e:
        print(f"Error writing to RDS: {e}")
        return False

def write_to_glue(data):
    try:
        for line in data:
            columns = line.split(',')
            glue_client.put_record(
                DatabaseName=GLUE_DATABASE,
                TableName="your_table",
                Record=columns
            )
        print("Data inserted into Glue successfully.")
    except Exception as e:
        print(f"Error writing to Glue: {e}")

def main():
    data = read_from_s3()
    if data:
        if not write_to_rds(data):
            write_to_glue(data)

if __name__ == "__main__":
    main()
