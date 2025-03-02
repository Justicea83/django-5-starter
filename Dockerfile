FROM python:3.10-buster
LABEL maintainer="Jay"

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN apt-get update && \
    apt-get install -y \
    libblas-dev \
    liblapack-dev \
    gfortran \
    supervisor && \
    rm -rf /var/lib/apt/lists/*

RUN python -m venv /py && \
    . /py/bin/activate && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp

ENV PATH="/py/bin:$PATH"

RUN mkdir /app/staticfiles
RUN mkdir /app/static

RUN chmod 777 /app/static
RUN chmod 777 /app/staticfiles