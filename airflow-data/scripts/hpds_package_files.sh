#!/bin/bash
echo "Package HPDS Binaries begin"
echo "$(pwd)" 
cp $2/encryption_key  .
cp $2/allObservationsStore.javabin .
cp $2/columnMeta.javabin .
ls -altr
tar -zcvf $1  encryption_key allObservationsStore.javabin columnMeta.javabin
ls -altr
chmod 777 $1
echo "copying .tar.gz to " $2
cp ./$1 $2
cd $2
chmod 777 $1
ls -lhrS
echo "Package HPDS Binaries end"