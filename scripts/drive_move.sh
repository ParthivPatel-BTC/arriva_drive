#!/bin/sh
LOG_FILE=/srv/drivedb.net/notify_emails.log
NEW_DIR_PATH=/srv/drivedb.net/mailboxes/notify/Maildir/new
CUR_DIR_PATH=/srv/drivedb.net/mailboxes/notify/Maildir/cur
echo "file moving processing" >> $LOG_FILE
mv $NEW_DIR_PATH/* $CUR_DIR_PATH
echo "files moved" >> $LOG_FILE