#!/bin/bash
echo "Transfer HPDS Binaries begin"
echo "$(pwd)"

echo "Input File: "$1
echo "S3 Bucket: "$2
echo "Path: "$3
echo "Target file: "$4

aws s3 cp $1 s3://$2/$3/$4 --sse aws:kms --sse-kms-key-id $AWS___DATA_ENCRYPTION_ARN

echo "Transfer HPDS Binaries end"