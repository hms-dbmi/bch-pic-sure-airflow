#!/bin/bash
  
echo "Decrypt S3 File begin"
echo $1 # file
echo $2 # decrypted file name
echo $3 # skip 

if [[ "$3" == "N" ]]; then
	_user="$(id -u -n)"
	_uid="$(id -u)"
	ls -altr 
	cd /opt/bitnami/airflow/airflow-data/downloads
	aws s3 cp  s3://$2/$1 .  
	
	aws-encryption-cli --decrypt \
	--input $1    \
	--encryption-context purpose=test  \
	--metadata-output metadata \
	--output $2
	--discovery true 
	
	ls -altr
elif [[ "$3" == "Y" ]]; then
	echo "Skipping: Decrypting the file"  
fi 

echo "Decrypt S3 File End" 