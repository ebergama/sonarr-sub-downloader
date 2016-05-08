#!/bin/bash
set -e

declare LOG_FILE=`dirname $0`/sub-downloader.log
echo $LOG_FILE
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

declare EPISODE_PATH=${sonarr_episodefile_path}

if [[ -z $EPISODE_PATH ]]; then
  doLog "sonarr_episodefile_path environment variable not found"
  exit 1
fi

doLog "Looking for subtitles for: ${EPISODE_PATH}"

declare SUBTITLE_FILE=`echo ${EPISODE_PATH} | sed "s/\(mkv\|mp4\)/es\.srt/g"`
doLog "Looking for the subtitle file: ${SUBTITLE_FILE}"

if [ ! -f "${SUBTITLE_FILE}" ]; then
  doLog "Subtitle not found, executing subliminal"
  echo $LOG_FILE
  subliminal download ${LANGUAGES} "${EPISODE_PATH}" >> $LOG_FILE 2>&1
else
  doLog "Subtitle exists" 
fi
