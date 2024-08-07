FROM apache/airflow:2.9.2-python3.12
#PYTHON_VERSION=3.12.4
RUN pip install --upgrade pip
COPY ./requirements.txt /opt/requirements.txt
RUN pip install -r /opt/requirements.txt