#!/bin/bash
clear
# Variables

wikiDB=pi_wiki
wikiDBuser=mwki
wikidir=/var/www/html/mediawiki
backupdir=~/wikibackup
timestamp=`date +%Y-%m-%d`
dbdump="$backupdir/wiki-$timestamp.sql.gz"
xmldump="$backupdir/wiki-$timestamp.xml.gz"
filedump="$backupdir/wiki-$timestamp.files.tar.gz"
logfile="$backupdir/backup-$timestamp.log"

echo "Wiki backup. Database: $wikiDB; User: $wikiDBuser; Directory: $wikidir; Backup to: $backupdir" | tee -a $logfile
echo
echo "creating database dump $dbdump..."
mysqldump --user=$wikiDBuser $wikiDB | gzip > "$dbdump" | tee -a $logfile
echo "Database dump complete"


echo
echo "creating XML dump $xmldump..." | tee -a $logfile
cd "$wikidir/maintenance" | tee -a $logfile
php -d error_reporting=E_ERROR dumpBackup.php --full | gzip > "$xmldump" | tee -a $logfile
echo "XML dump complete" | tee -a $logfile


echo
echo "creating file archive $filedump..." | tee -a $logfile
cd "~" | tee -a $logfile
tar -czvf "$filedump" "$wikidir" | tee -a $logfile
echo "Filesystem backup complete" | tee -a $logfile
echo
echo "Wiki backup complete" | tee -a $logfile
