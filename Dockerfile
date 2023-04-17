FROM python:3.8-slim
ENV PYTHONUNBUFFERED=1

RUN pip install --upgrade pip


RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    libjpeg-dev \
    zlib1g-dev \
    libjpeg-dev \
    postgresql-server-dev-all

WORKDIR /code

COPY requirements.txt /code/

RUN pip install --no-cache-dir --use-deprecated=legacy-resolver -r requirements.txt

RUN pip install psycopg2-binary

COPY . /code/
