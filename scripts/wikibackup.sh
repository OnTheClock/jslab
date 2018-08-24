#!/bin/bash
clear
# Variables

wikiDB=pi_wiki
wikiDBuser=mwki
wikidir=/var/www/html/mediawiki
timestamp=`date +%y.%m.%d-%H.%M`
mkdir "$HOME/wikibackup/$timestamp"
backupdir="$HOME/wikibackup/$timestamp"
dbdump="$backupdir/wiki-$timestamp.sql.gz"
xmldump="$backupdir/wiki-$timestamp.xml.gz"
filedump="$backupdir/wiki-$timestamp.files.tar.gz"

echo "Wiki backup. Database: $wikiDB; User: $wikiDBuser; Directory: $wikidir; Backup to: $backupdir"
echo
echo "creating database dump $dbdump..."
mysqldump --user=$wikiDBuser $wikiDB | gzip > "$dbdump"
echo "Database dump complete"


echo
echo "creating XML dump $xmldump..."
cd "$wikidir/maintenance"
php -d error_reporting=E_ERROR dumpBackup.php --full | gzip > "$xmldump"
echo "XML dump complete"


echo
echo "creating file archive $filedump..."
cd "$HOME"
tar -czvf "$filedump" "$wikidir"
echo "Filesystem backup complete"
echo
echo "Wiki backup complete"
echo
cd "$HOME/wikibackup"
ls -t | sed -e '1,12d' | xargs -d '\n' rm
echo "Log rotation complete"
