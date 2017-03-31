#!/bin/bash

export PATH=$PATH:/usr/local/bin/

########################################
# Initial Settings
########################################
#SCRIPT_NAME=${0##*/}
#SCRIPT_VERSION=1.1

instanceid=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
#azone=`wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone`
#region=${azone/%?/}
#export EC2_REGION=$region

########################################
#CLOUDWATCH_OPTS="--namespace Postgres Metrics --dimensions InstanceId=$instanceid"
#if [ -n "$PROFILE" ]; then
#    CLOUDWATCH_OPTS="$CLOUDWATCH_OPTS --profile $PROFILE"
#fi

########################################
TOTAL_IDLE=`psql -c "select count(*) from pg_stat_activity where state='idle'"| head -n3|tail  -n1`
TOTAL_ACTIVE=`psql -c "select count(*) from pg_stat_activity where state='active'"| head -n3|tail  -n1`

aws cloudwatch put-metric-data --metric-name "IdleConnections" --value "$TOTAL_IDLE" --unit "Count" --namespace "Postgres Metrics" --dimensions InstanceId=$instanceid
aws cloudwatch put-metric-data --metric-name "ActiveConnections" --value "$TOTAL_ACTIVE" --unit "Count" --namespace "Postgres Metrics" --dimensions InstanceId=$instanceid
