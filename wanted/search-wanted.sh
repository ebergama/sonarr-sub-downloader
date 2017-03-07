#!/bin/bash

declare WANTED_FILE=`dirname $0`/subs.wanted

declare MISSED=""
echo "###### Process started at: $(date) ######"

while IFS=':' read -a line; do
  SOURCE=${line[0]}
  SRT=${line[1]}
  LANG=`echo $SRT | sed -e "s/\.srt//g" -e "s/.*\(..\)/\1/"`
  echo "subliminal download -l $LANG $SOURCE"
  subliminal download -l $LANG "$SOURCE"
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
