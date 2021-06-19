#!/bin/bash
echo "Download Files Begin"
_user="$(id -u -n)"
_uid="$(id -u)"
cd /opt/bitnami/airflow/airflow-data/downloads
	
for var in "$@"
do
	echo ""
    echo "$var"
    IFS=','
    read -a strarr <<< "$var" 
    echo "Downloading File: "${strarr[0]}" , Location: "${strarr[1]}", Final Name: "${strarr[2]}
    aws s3 cp  s3://${strarr[1]} ${strarr[0]}
    echo ""
    
done


chmod -R 777 /opt/bitnami/airflow/airflow-data/downloads
ls -altr

echo "Download Files End"