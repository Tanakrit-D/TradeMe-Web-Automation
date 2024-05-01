FROM python:3.12-slim
RUN find / -name pip
RUN pip install poetry