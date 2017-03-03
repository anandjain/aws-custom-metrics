#!/bin/bash
#Installing required services
OS_NAME=`cat /etc/*release | grep -i "^NAME" | cut -d"=" -f2`

case $OS_NAME in
        '"Ubuntu"')
                sudo apt-get update -y; sudo apt-get install git unzip awscli wget -y
		git clone https://github.com/anandjain/aws-custom-metrics.git
        ;;
        '"Debian"')
                sudo apt-get update -y ; sudo apt-get install git unzip awscli wget -y
		git clone https://github.com/anandjain/aws-custom-metrics.git
        ;;
        *)
                sudo yum update -y ; sudo yum install git unzip wget -y
		# Configure AWS-CLI
                echo "Installing aws-cli..."
                curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
                unzip awscli-bundle.zip
                sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
                sudo rm awscli-bundle.zip
                # Configure AWS-CLI
                if [ ! -d ~/.aws ]
                   then
                        mkdir -p ~/.aws
                fi
		git clone https://github.com/anandjain/aws-custom-metrics.git
        ;;
esac

