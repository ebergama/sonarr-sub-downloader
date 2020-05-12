#!/bin/bash

source `dirname $0`/../properties_parser.sh

declare DOWNLOADER_PROPERTIES=`dirname $0`/../downloader.properties
declare WANTED_FILE=`dirname $0`/subs.wanted

declare MISSED=""
echo "#########################################"
echo "###### Process started at: $(date) ######"
echo "#########################################"

LANGUAGE=`propLanguages $DOWNLOADER_PROPERTIES`
CREDENTIALS=`propCredentials $DOWNLOADER_PROPERTIES`

while IFS=':' read -a line; do
  SOURCE=${line[0]}
  SRT=${line[1]}

  COMMAND="subliminal $CREDENTIALS download $LANGUAGE \"$SOURCE\""

  echo $COMMAND
  eval $COMMAND
  
  if [[ ! -f $SRT ]]; then
    IFS=''
    MISSED="$SOURCE:$SRT\n$MISSED"
    echo "Subtitle still not available"
  else 
    echo "Great! we have found $SRT"
  fi
done < "$WANTED_FILE"

echo "Saving not found subtitles"
echo -en $MISSED > $WANTED_FILE
