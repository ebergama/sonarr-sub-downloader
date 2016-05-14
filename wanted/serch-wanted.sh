#!/bin/bash

declare WANTED_FILE=`dirname $0`/subs.wanted

declare MISSED=""

while read -r line; do
  MAP_ARRAY=($(echo "$line" | sed "s/:/ /g"))
  SOURCE=${MAP_ARRAY[0]}
  SRT=${MAP_ARRAY[1]}
  LANG=`echo $SRT | sed -e "s/\.srt//g" -e "s/.*\(..\)/\1/"`
  echo "subliminal download -l $LANG $SOURCE"
  subliminal download -l $LANG $SOURCE
  if [[ ! -f $SRT ]]; then
    MISSED="$SOURCE:$SRT\n$MISSED"
    echo "Subtitle still not available"
  else
    echo "Great! we have found $SRT"
  fi
done < "$WANTED_FILE"

echo "Saving not found subtitles"
echo -en $MISSED > $WANTED_FILE