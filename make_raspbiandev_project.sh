#!/bin/bash

LOG=/var/run/nohup.log


[ "$1" == "" ] && 
echo "
Calls raspbiandev docker container
changes to project directory (from /development)
calls make -j4 in the BACKGROUND

logs to:
$LOG
" && 
exit

[ ! -d "../$1" ]  && 
  echo "Project directory \"$1\" not found"  &&
  exit


echo "

Making $1 in background
"

nohup ./run.sh "export LD_LIBRARY_PATH=/opt/vc/lib; cd $1; git pull; svn update; make -j4" > $LOG &

CHILD=$!
CHILD_CMD=$(ps -ea | grep $CHILD | grep -v "grep")

echo "
Running as process:
$CHILD

Command line:
$CHILD_CMD

Trace logs with:
tail -f $LOG
"

