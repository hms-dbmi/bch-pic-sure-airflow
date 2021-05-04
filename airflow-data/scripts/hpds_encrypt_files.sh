#!/bin/bash
echo "Encrypt HPDS Binaries begin"
echo "$(pwd)"

echo "Input File: "$1
echo "Output File: "$2

cmkArn=$AWS___DATA_ENCRYPTION_ARN

aws-encryption-cli --encrypt \
         --input $1 \
         --wrapping-keys key=$cmkArn \
         --encryption-context purpose=test \
         --commitment-policy require-encrypt-require-decrypt \
         --metadata-output ~/metadata \
         --output $2
chmod 777 $2
ls -lhrS
echo "Encrypt HPDS Binaries end"  