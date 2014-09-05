#!/bin/sh
CUR_DIR_PATH=/srv/drivedb.net/mailboxes/notify/Maildir/cur/*
LOG_FILE=/srv/drivedb.net/notify_emails.log
BACKUP_DIR_PATH=/srv/drivedb.net/notify_backup/
HOST='http://localhost:3000'

for f in $CUR_DIR_PATH
do
  filename=$f
  to=`grep 'Envelope-to:' $f`;
  content=$(cat $filename)
  echo "PROCESSING ==> $filename" >> $LOG_FILE
  status=$(curl --write-out "%{http_code}\n" --silent --output /dev/null --request POST '$HOST/participants/participant_attachments/callback/'  --data-urlencode "content=${content}" --data-urlencode "to=${to}")
  echo "PROCESSED with status code ==> $status" >> $LOG_FILE
  if [ $status -eq 200 ]; then
    mv $filename $BACKUP_DIR_PATH
    echo "File Moved" >> $LOG_FILE
  fi
  sleep 5s
done