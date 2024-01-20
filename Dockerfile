FROM python:3.10-slim

COPY . /main

WORKDIR /main

RUN pip install -r requirements.txt

CMD uvicorn main:app --host 0.0.0.0 --port 8000 