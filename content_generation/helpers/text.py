import os
import re
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.document_loaders import S3FileLoader

aws_access_key_id = os.getenv('AWS_ACCESS_KEY_ID')
aws_secret_access_key = os.getenv('AWS_SECRET_ACCESS_KEY')

def extract_video_id(url):
    # Regular expression pattern for extracting video ID from YouTube URL
    pattern = r'(?:https?://)?(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/)([a-zA-Z0-9_-]{11})(?:\S*)'
    match = re.match(pattern, url)
    if match:
        return match.group(1)
    else:
        return None

def split_text(text, chunk_size = 2500, chunk_overlap = 20):
    text_splitter = RecursiveCharacterTextSplitter(
        # Set a really small chunk size, just to show.
        chunk_size=chunk_size,
        chunk_overlap=chunk_overlap,
        length_function=len,
        is_separator_regex=False,
        separators=['\n\n', '\n', '.']
    )
    split_text = text_splitter.split_text(text)
    return split_text

def split_s3_file(bucket, file):
    res_file = S3FileLoader(
        bucket, file, aws_access_key_id=aws_access_key_id, aws_secret_access_key=aws_secret_access_key
    )

    return res_file.load()
