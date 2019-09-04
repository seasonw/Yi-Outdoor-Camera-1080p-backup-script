TOTAL_DAYS_KEEP=30
BACKUP_MAINFOLDER="/mnt/hdd1"

eldestdate=$(date +%Y%m%d  -d "now - $TOTAL_DAYS_KEEP days")
echo "Eldest Date for log files: $eldestdate"

datenow=$(date +%YY%mM%dD)
datetimenow=$(date +%YY%mM%dD%TT)
cd $BACKUP_MAINFOLDER
for file in *.log; do
    filename=$(echo "$(basename "$file")")
    filedatestr=$(echo ${filename:0:4}${filename:5:2}${filename:8:2})
    if [ $filedatestr -le $eldestdate ]
    then
        rm -R $filename
        echo "Deleted log file: $filename" >> "$datenow".log 2>&1
    fi
done

cd $BACKUP_MAINFOLDER
./backup141.sh > "$datetimenow"141IP.log 2>&1

echo "Backup completed!"
