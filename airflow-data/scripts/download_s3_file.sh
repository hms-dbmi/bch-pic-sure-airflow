#!/bin/bash
  
echo "Download S3 File begin"
echo $1 # file
echo $2 # bucket
echo $3 # skip 

if [[ "$3" == "N" ]]; then
	_user="$(id -u -n)"
	_uid="$(id -u)"
	ls -altr 
	cd /opt/bitnami/airflow/airflow-data/downloads
	aws s3 cp  s3://$2/$1".encrypted" . 
	chmod -R 777 /opt/bitnami/airflow/airflow-data/downloads
	ls -altr
elif [[ "$3" == "Y" ]]; then
	echo "Skipping: Download the file"  
fi 

echo "Download S3 File End" 