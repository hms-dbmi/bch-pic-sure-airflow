FROM dbmi/airflow:dbmi-airflow-worker-oct2020
MAINTAINER ANIL KUMAR DEGALA <anilkdegala@gmail.com>
RUN pip install pandasql
RUN pip install fire
RUN pip install awscli==1.19.1
RUN pip uninstall -y aws-encryption-sdk-cli
RUN pip install aws-encryption-sdk-cli==2.0.0
RUN mkdir /opt/bitnami/airflow/airflow-data/
RUN chmod -R 777 /opt/bitnami/airflow/airflow-data/