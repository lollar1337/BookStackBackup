# Check if temp dir exists and creating one if not
if [ -d "/temp" ]; then
	echo "dir exists - nothing to do"
else
	mkdir /temp
fi

# Archive Name Variable
ARCHIVE_NAME=bookstack-files-backup-$(date '+%Y-%m-%d').tar.gz

# Dump the SQL Database to temp Folder
sudo mysqldump -u root bookstack > /temp/bookstack.backup.sql

# Copy the SQL file to bookstack folder
cp /temp/bookstack.backup.sql /var/www/bookstack/


cd /var/www/bookstack

# Create a Archive with all the relevant files that need to be backed up
tar -czvf /temp/$ARCHIVE_NAME .env public/uploads storage/uploads bookstack.backup.sql

# Copy the Archive to backup location
cp /temp/$ARCHIVE_NAME [destination]

# Clear temporary Folder
rm -r /temp/*

# Delete the SQL Backup from the bookstack folder
rm bookstack.backup.sql
