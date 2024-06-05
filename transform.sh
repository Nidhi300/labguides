#!/bin/bash
echo $1
echo $2
cp m2kconfig-main.yaml m2kconfig.yaml
sed -i "s/appName/$2/g" m2kconfig.yaml
move2kube transform -s $1 --config m2kconfig.yaml
