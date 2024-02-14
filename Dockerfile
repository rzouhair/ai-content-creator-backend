FROM python:3.8-slim
ENV PYTHONUNBUFFERED=1

RUN pip install --no-cache-dir --upgrade pip


RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    zlib1g-dev \
    libjpeg-dev \
    postgresql-server-dev-all

RUN apt-get install poppler-utils libleptonica-dev tesseract-ocr liblept5 libtesseract-dev python3-pil tesseract-ocr-eng tesseract-ocr-script-latn -y

WORKDIR /code

COPY requirements.txt /code/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /code/
