#!/bin/bash
echo "Decrypt Files Begin"
_user="$(id -u -n)"
_uid="$(id -u)"
cd /opt/bitnami/airflow/airflow-data/downloads
	
for var in "$@"
do
	echo ""
    echo "$var"
    IFS=','
    read -a strarr <<< "$var" 
    echo "Decrypting File: "${strarr[0]}" , Location: "${strarr[1]}

	aws-encryption-cli --decrypt \
	--input ${strarr[0]}".encrypted"    \
	--encryption-context purpose=test  \
	--metadata-output metadata \
	--output ${strarr[0]} \
	--discovery true 
	    
    echo ""
    
done


chmod -R 777 /opt/bitnami/airflow/airflow-data/downloads
ls -altr

echo "Decrypt Files End"