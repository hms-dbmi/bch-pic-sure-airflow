#!/bin/bash
  
echo "Decrypt S3 File begin"
echo $1 # file
echo $2 # skip 

if [[ "$2" == "N" ]]; then
	_user="$(id -u -n)"
	_uid="$(id -u)"
	ls -altr 
	cd /opt/bitnami/airflow/airflow-data/downloads
	
	aws-encryption-cli --decrypt \
	--input $1".encrypted"    \
	--encryption-context purpose=test  \
	--metadata-output metadata \
	--output $1 \
	--discovery true  
	
	ls -altr
	
elif [[ "$2" == "Y" ]]; then
	echo "Skipping: Decrypting the file"  
fi 

echo "Decrypt S3 File End"