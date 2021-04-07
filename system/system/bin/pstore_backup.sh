#!/system/bin/sh

max_count=10
result_file=/data/ramoops/pstore_backup_result
backup_folder=/data/ramoops
logger_folder=/data/logger
result_file=/data/ramoops/pstore_backup_result
count_file=$backup_folder/pstore_next_count
pstore_part=/dev/block/bootdevice/by-name/pstore
kernel_enable=`getprop persist.vendor.lge.service.kernel.enable`
logger_folder=/data/logger
do_copy=0
copy_ramoops()
{
    case "$kernel_enable" in
	"0")
	    ;;
	*)
	    cp -fa $backup_folder/* $logger_folder/
	    ;;
    esac
}

rm -f $result_file

/system/bin/pstore_backup $pstore_part

if [ -f $result_file ] ; then
    if [ -f $count_file ] ; then
        count=`cat $count_file`
        case $count in
            "" ) count=0
        esac
    else
        count=0
    fi
    echo [[[[ Written $backup_folder/pstore_backup$count $max_count ]]]]
    mv $result_file $backup_folder/pstore_backup$count
    # reason is att permission certification
    chmod -h 664 $backup_folder/pstore_backup$count
    count=$(($count+1))
    if (($count>=$max_count)) ; then
        count=0
    fi
    echo $count > $count_file
    chmod -h 664 $count_file
    do_copy=1
fi

if [ do_copy -eq 1 ] ; then
    copy_ramoops
fi
