#!/bin/sh

#PATH_ANDROID=/sdcard/Movies/Screenrecord/
PATH_ANDROID=/sdcard/

function stop_screenrecord() {
    echo "record stop"
    kill ${PID}
}

if [ -z "$2" ]
then
    PATH_LOCAL=~/Movies/
else
    PATH_LOCAL=$2
fi

if [ -z "$1" ]
then
    DATE=`date +"%Y%m%d%H%M%S"`
    EXTENSION=.mp4
    FILE_NAME=${DATE}${EXTENSION}
else
    FILE_NAME=$1
fi

echo "record ${FILE_NAME} start"
#adb shell screenrecord ${PATH_ANDROID}${FILE_NAME} --time-limit 10 &
adb shell screenrecord ${PATH_ANDROID}${FILE_NAME} &
PID=$!

trap stop_screenrecord 2 15

wait ${PID} #2>/dev/null

trap '' 2 15 # 無効にする
echo "record ${FILE_NAME} end"
sleep 5 # 動画が端末に保存されるまで待つ
echo "pull ${FILE_NAME} start"
adb pull ${PATH_ANDROID}${FILE_NAME} ${PATH_LOCAL}
adb shell rm ${PATH_ANDROID}${FILE_NAME}
echo "pull ${FILE_NAME} end"
trap 2 15 # 元に戻す

