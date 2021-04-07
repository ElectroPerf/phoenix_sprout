#!/system/bin/sh
#
# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# This script copies preloaded content from system_b to data partition
# create files with 644 (global read) permissions.
umask 022
if [ $# -eq 1 ]; then
  PAI_APPLIED_DEVICES=(phoenix_lao_com)

  # Where the system_b is mounted that contains the preloads dir
  mountpoint=$1
  dest_dir=/data/preloads
  dest_pai_dir=/data/preloads/file_cache/com.android.vending
  log -p i -t preloads_copy "Copying from $mountpoint/preloads"
  # Parallelize by copying subfolders and files in the background
  for file in $(find ${mountpoint}/preloads -mindepth 1 -maxdepth 1); do
       foldername=${file##*/}
       ispaiapp=0
       # make a folder for PAI preinstall
       if [ ! -d $dest_pai_dir ];then
         mkdir -p $dest_pai_dir
       fi

       # check a item is a PAI app, and then copy it into PAI path
       for paidevice in ${PAI_APPLIED_DEVICES[@]}
       do
           if [ "$paidevice" == "$foldername" ];then
               ispaiapp=1
               break
           fi
       done

       if [ "$ispaiapp" == "0" ];then
           cp -rn $file $dest_dir &
       else
           cp -rn $file/*/*.apk $dest_pai_dir &
       fi
  done

  # Wait for jobs to finish
  wait
  log -p i -t preloads_copy "Copying complete"
  exit 0
else
  log -p e -t preloads_copy "Usage: preloads_copy.sh <system_other-mount-point>"
  exit 1
fi

