#!/bin/bash
set -e
echo `dirname $0`
declare LOG_FILE=~/logs/subs-downloader.log
declare WANTED_FILE=`dirname $0`/wanted/subs.wanted
declare DOWNLOADER_PROPERTIES=`dirname $0`/downloader.properties

source `dirname $0`/properties_parser.sh

# Sonarr does not show the stdout as part of the log information displayed by the system,
# So I decided to store the log information by my own.
function doLog {
  echo -e $1
  echo -e $1 >> $LOG_FILE
}

function printUsage {
  msg="Usage: sub-downloader.sh\n\n
    This script relies on dowloader.properties, please fill \n\n
    -h, --help: print this help"
  doLog "$msg"
  exit 1
}

if [[ "$1" == '-h' ]]; then
  printUsage
fi

doLog "###### Process started at: $(date) ######"

LANGUAGES=`propLanguages $DOWNLOADER_PROPERTIES`
CREDENTIALS=`propCredentials $DOWNLOADER_PROPERTIES`

declare VIDEO_PATH=${sonarr_episodefile_path}
if [[ -z $VIDEO_PATH ]]; then
  doLog "Sonarr sonarr_episodefile_path not found. Maybe a Radarr movie?"
  VIDEO_PATH=${radarr_moviefile_path}
fi

if [[ -z $VIDEO_PATH ]]; then
  doLog "sonarr_episodefile_path not radarr_movie_path environment variable not found"
  exit 1
fi

doLog "Looking for subtitles for: ${VIDEO_PATH}"

doLog "Executing subliminal, using $CREDENTIALS, and language $LANGUAGES"
COMMAND="subliminal --debug $CREDENTIALS download $LANGUAGES \"$VIDEO_PATH\" >> $LOG_FILE 2>&1"
eval $COMMAND   

# Look for not found subtitles
declare LANG_ARRAY=($(echo ${LANGUAGES} | sed "s/-l //g"))

for LANG in "${LANG_ARRAY[@]}"; do
  SUB_FILE="${VIDEO_PATH%.*}.${LANG}.srt"
  if [[ ! -f $SUB_FILE ]]; then
    doLog "Subtitle ${SUB_FILE} not found, adding it to wanted"
    echo $VIDEO_PATH:$SUB_FILE >> ${WANTED_FILE}
  fi
done
