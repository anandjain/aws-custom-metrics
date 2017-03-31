#!/bin/bash
touch /opt/logs/pg_mem_log/pglogs_in_seconds.log
MaxFileSize=1024000000

while true
   do
    	date +%c >> /opt/logs/pg_mem_log/pglogs_in_seconds.log; awk '$3=="kB"{$2=$2/1024;$3="MB"} 1' /proc/meminfo | column -t | grep -i 'MemFree\|SwapFree' >> /opt/logs/pg_mem_log/pglogs_in_seconds.log
    	psql -c "select usename,state,count(*),array_agg(pid) from pg_catalog.pg_stat_activity where state !='idle' group by 1,2" >> /opt/logs/pg_mem_log/pglogs_in_seconds.log
     	#psql -c "select state,count(*) from pg_stat_activity group by 1 order by 1" >> /opt/logs/pg_mem_log/pglogs_in_seconds.log
	sleep 1

	#Get size in bytes**
	file_size=`du -b /opt/logs/pg_mem_log/pglogs_in_seconds.log | tr -s '\t' ' ' | cut -d' ' -f1`
    if [ $file_size -gt $MaxFileSize ];then
        timestamp=`date +%s`
        mv /opt/logs/pg_mem_log/pglogs_in_seconds.log /opt/logs/pg_mem_log/pglogs_in_seconds.log.$timestamp
        touch /opt/logs/pg_mem_log/pglogs_in_seconds.log
        sleep 1
    fi
done
