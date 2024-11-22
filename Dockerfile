# Use a lightweight Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir boto3 pymysql

# Command to run the application
CMD ["python", "main.py"]
