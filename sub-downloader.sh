#!/bin/bash
set -e
echo `dirname $0`
declare LOG_FILE=~/logs/subs-downloader.log
declare WANTED_FILE=`dirname $0`/wanted/subs.wanted

# Sonarr does not show the stdout as part of the log information displayed by the system,
# So I decided to store the log information by my own.
function doLog {
  echo -e $1
  echo -e $1 >> $LOG_FILE
}

function printUsage {
  msg="Usage: sub-downloader.sh [options]\n\n
    -l, --languages <languages-list>:\n
    \t Specify a comma-separated list of languages to download.\n
    \t example: sub-downloader.sh -l es,en\n\n
    -h, --help: print this help"
  doLog "$msg"
  exit 1
}

if [[ $# -eq 0 ]]; then
  printUsage
fi

while [ "$1" != "" ]; do
  case $1 in
    "-l" | "--languages")
      shift
      declare LANGUAGES=$(echo "-l $1" | sed "s/,/ -l /g")
      ;;
    *)
      printUsage
      ;;
  esac
  shift
done

doLog "###### Process started at: $(date) ######"

declare VIDEO_PATH=${sonarr_episodefile_path}
if [[ -z $VIDEO_PATH ]]; then
  doLog "Sonarr sonarr_episodefile_path not found. Maybe a Radarr movie?"
  VIDEO_PATH=${radarr_movie_path}
fi

if [[ -z $VIDEO_PATH ]]; then
  doLog "sonarr_episodefile_path not radarr_movie_path environment variable not found"
  exit 1
fi

doLog "Looking for subtitles for: ${VIDEO_PATH}"

doLog "Executing subliminal"
doLog "subliminal download ${LANGUAGES} ${VIDEO_PATH}"
subliminal download ${LANGUAGES} "${VIDEO_PATH}" >> $LOG_FILE 2>&1
  
# Look for not found subtitles
declare LANG_ARRAY=($(echo ${LANGUAGES} | sed "s/-l //g"))

for LANG in "${LANG_ARRAY[@]}"; do
  SUB_FILE="${VIDEO_PATH}.${LANG}.srt"
  if [[ ! -f $SUB_FILE ]]; then
    doLog "Subtitle ${SUB_FILE} not found, adding it to wanted"
    echo $VIDEO_PATH:$SUB_FILE >> ${WANTED_FILE}
  fi
done
