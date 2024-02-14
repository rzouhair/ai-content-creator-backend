from core.clients import s3_client

def upload_to_s3(file, bucket_name, key, file_name):
  path = f"{key}_{file_name}"
  file = s3_client.put_object(Bucket=bucket_name, Key=path, Body=file)
  # file = s3_client.put_object(file, bucket_name, path)
  return {
    'url': f"https://{bucket_name}.s3.{'us-east-1'}.amazonaws.com/{path}",
    'path': path,
  }