TOTAL_DAYS_KEEP=30
IP_ADDRESS="192.168.2.141"
BACKUP_MAINFOLDER="/mnt/hdd1"
BACKUP_SUBFOLDER="tmp/sd/record/"

eldestdate=$(date +%Y%m%d  -d "now - $TOTAL_DAYS_KEEP days")
echo "Eldest Date for recorded videos: $eldestdate"

cd $BACKUP_MAINFOLDER/$IP_ADDRESS/$BACKUP_SUBFOLDER
for dir in */; do
    dirname=$(echo "$(basename "$dir")")
    #dirname=$(echo $dir| cut -d'/' -f 1)
    dirdatestr=$(echo ${dirname:0:4}${dirname:5:2}${dirname:8:2})
    if [ $dirdatestr -le $eldestdate ]
    then
        rm -R $dirname
        echo "Deleted folder: $dirname"
    fi
done

cd $BACKUP_MAINFOLDER
wget -nc -r -l 0 ftp://root:@192.168.2.141//tmp/sd/record/*
