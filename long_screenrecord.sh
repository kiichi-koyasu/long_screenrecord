#!/bin/sh

EXTENSION=.mp4
PATH_LOCAL=~/Movies/
LIST_FILE=list.txt

function stop_record() {
    kill ${PID}
    STOP=1
}

FILE_NAME_ARRAY=()
PID_ARRAY=()
STOP=0

trap stop_record 2 15

while [ $STOP = 0 ]
do
    DATE=`date +"%Y%m%d%H%M%S"`
    FILE_NAME=${DATE}${EXTENSION}
    FILE_NAME_ARRAY+=(${FILE_NAME})
    sh my_screenrecord.sh ${FILE_NAME} ${PATH_LOCAL} &
    PID=$!
    PID_ARRAY+=(${PID})
    sleep 180
done

wait ${PID_ARRAY[@]}

# 動画連結
pushd ${PATH_LOCAL}

if [ -e ${LIST_FILE} ]
then
  rm ${LIST_FILE}
fi

touch ${LIST_FILE}

for i in "${FILE_NAME_ARRAY[@]}"
do
  echo "file '${i}'" >> ${LIST_FILE}
done

ffmpeg -f concat -i ${LIST_FILE} -c copy temp.mp4

for i in "${FILE_NAME_ARRAY[@]}"
do
  rm ${i}
done
rm ${LIST_FILE}
mv temp.mp4 ${FILE_NAME_ARRAY}

popd
