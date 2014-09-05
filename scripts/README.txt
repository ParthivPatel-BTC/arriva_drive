Path Details:
=============
Mailbox: /srv/drivedb.net/mailboxes/notify
New Directory Path: /srv/drivedb.net/mailboxes/notify/Maildir/new
Current Directory Path: /srv/drivedb.net/mailboxes/notify/Maildir/cur
Host: http://stg.drivedb.net
Log File Path: /srv/drivedb.net/notify_emails.log
Mails Backup Directory Path: /srv/drivedb.net/notify_backup/

Steps:
======
1. Copy "drive_move.sh", "drive_post.sh" and "cron_job_file" files to desired location.
2. Create log file at Log File Path
3. Create backup folder for storing processed mails at Mails Backup Directory Path
4. Modify Host(if required) in "drive_post.sh" script file
5. Modify the directory paths in "drive_post.sh" and "drive_move.sh" files if necessary.
6. Modify Paths to "drive_move.sh" and "drive_post.sh" files in "cron_job_file".
7. Start the cron job using following command from the directory where "cron_job_file" is copied
    $> crontab cron_job_file
8. Verify that the cron jobs have started and the following command has two entries as below:
    $> crontab -l
      * * * * * /home/parthiv/drive_move.sh
      */10 * * * * /home/parthiv/drive_post.sh
9. Once the cron job has started, The mails will be read from the mailbox at an interval of 10 minutes