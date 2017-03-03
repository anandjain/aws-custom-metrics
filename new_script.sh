#!/bin/bash

if [ -x "$(command -v git)" ]; then
    if [ -x "$(command -v unzip )" ]; then
     if [ -x "$(command -v wget )" ]; then
        if [ -x "$(command -v aws)" ]; then
                echo "Please configre your AWS Secret and Access Keys"
                # Set credentials for AWS
                aws configure
                else
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
                # Set credentials for AWS
                $AWS_PATH configure
                git clone https://github.com/anandjain/aws-custom-metrics.git
                cd aws-custom-metrics
                ./aws-metrics.sh --help
               fi
      else
        echo "The program 'wget' is currently not installed., Please install and run the script"
      fi

    else
       echo "The program 'unzip' is currently not installed., Please install and run the script"
   fi
else
    if [ -x "$(command -v unzip)" ]; then
        echo "The program 'git' is currently not installed., Please install and run the script"
    else
        echo "'git' & 'unzip' are currently not installed., Please install and run the script" 
    fi
fi
