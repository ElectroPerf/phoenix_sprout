#!/system/bin/sh
log_enabled=$(getprop ro.product.lge.logger.enable)
if [ "$log_enabled" != "true" ];
then
    exit 0
fi

log_file="events.log"

events_log_prop=`getprop persist.vendor.lge.service.events.enable`
log_size_prop=`getprop persist.product.lge.service.logsize.setting`
storage_low_prop=`getprop persist.product.lge.service.logger.low`

file_size_kb=8192
file_cnt=0

if [[ $log_size_prop > 0 ]]; then
   file_size_kb=$log_size_prop
fi

if [ "$storage_low_prop" = "1" ]; then
   file_size_kb=1024
fi

touch /data/logger/${log_file}
chmod 0644 /data/logger/${log_file}

case "$events_log_prop" in
        #6)
        #    file_size_kb=512
        #    file_cnt=4
        #    ;;
        5)
            file_cnt=99
            ;;
        4)
            file_cnt=49
            ;;
        3)
            file_cnt=19
            ;;
        2)
            file_cnt=9
            ;;
        1)
            file_cnt=4
            ;;
        0)
            file_cnt=0
            ;;
        *)
            file_cnt=0
            ;;
esac

if [[ $file_cnt > 0 ]]; then
    /system/bin/logcat -v threadtime -b events -f /data/logger/${log_file} -n $file_cnt -r $file_size_kb
fi

