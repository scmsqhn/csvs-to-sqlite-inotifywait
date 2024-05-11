#!/bin/bash
CTNNAME=amc-amd64-python3.8
IMGNAME=amc/amd64-python3.8
docker stop $CTNNAME
docker rm $CTNNAME
docker run --name $CTNNAME \
           -v ./csv2sql3:/opt/csv2sql3 \
           -v /tmp/csv_input:/opt/data/csv_sql/csv_input \
           -v /tmp/sqlite3_db_output:/opt/data/csv_sql/sqlite3_db_output \
           -itd $IMGNAME sh -c "nohup /opt/csv2sql3/inotify_cmd.sh >/opt/csv2sql3/inotifywait.log 2>&1 & \
           tail -f /opt/csv2sql3/inotifywait.log"
