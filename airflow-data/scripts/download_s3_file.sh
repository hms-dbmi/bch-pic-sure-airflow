#!/bin/bash
  
echo "Download S3 File begin"
echo $1 # s3_bucket
echo $2 # log_file
echo $3 # s3_object
echo $4 # skip 

if [[ "$4" == "N" ]]; then
	_user="$(id -u -n)"
	_uid="$(id -u)"
	ls -altr 
	cd /opt/bitnami/airflow/airflow-data/downloads
	aws s3 cp  s3://$1/$2".encrypted" $3".encrypted" 
	chmod -R 777 /opt/bitnami/airflow/airflow-data/downloads
	ls -altr
elif [[ "$3" == "Y" ]]; then
	echo "Skipping: Download the file"  
fi 

echo "Download S3 File End"