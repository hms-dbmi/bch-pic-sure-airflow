#!/bin/bash
echo "Generate Encryption Key:  begin" 
echo "$(pwd)" 

echo "` < /dev/urandom tr -dc A-F0-9 | head -c${1:-32}`" > /opt/bitnami/airflow/airflow-data/hpds-bch-etl/hpds/encryption_key
chmod 777 /opt/bitnami/airflow/airflow-data/hpds-bch-etl/hpds/encryption_key
cat /opt/bitnami/airflow/airflow-data/hpds-bch-etl/hpds/encryption_key
ls -altr /opt/bitnami/airflow/airflow-data/hpds-bch-etl/hpds

echo "Generate Encryption Key:  end"