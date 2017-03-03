#!/bin/bash
#Installing required services
OS_NAME=`cat /etc/*release | grep -i "^NAME" | cut -d"=" -f2`

case $OS_NAME in
        '"Ubuntu"')
                sudo apt-get update -y; sudo apt-get install git unzip awscli wget -y
                wget https://raw.githubusercontent.com/anandjain/aws-custom-metrics/master/new_script.sh  
                sh new_script.sh
        ;;
        '"Debian"')
                sudo apt-get update -y ; sudo apt-get install git unzip awscli wget -y
                wget https://raw.githubusercontent.com/anandjain/aws-custom-metrics/master/new_script.sh 
                sh new_script.sh
        ;;
        *)
                sudo yum update -y ; sudo yum install git unzip wget -y
                wget https://raw.githubusercontent.com/anandjain/aws-custom-metrics/master/new_script.sh 
                sh new_script.sh
        ;;
esac

