#!/bin/bash
set -e

function printUsage {
  echo "Usage: ./sub-downloader.sh <LOG_FILE_PATH> <language>"
}

if [[ $# -eq 0 ]]; then
  printUsage
  exit 1
fi

declare LOG_FILE=$1
declare LANGUAGE=$2

# Sonarr does not show the stdout as part of the log information displayed by the system,
# So I decided to store the log information by my own.
function doLog {
  echo $1
  echo $1 >> $LOG_FILE
}

doLog "###### Process started at: $(date) ######"

declare EPISODE_PATH=${sonarr_episodefile_path}

doLog "Looking for subtitles for: ${EPISODE_PATH}"

declare SUBTITLE_FILE=`echo ${EPISODE_PATH} | sed "s/\(mkv\|mp4\)/es\.srt/g"`
doLog "Looking for the subtitle file: ${SUBTITLE_FILE}"

if [ ! -f "${SUBTITLE_FILE}" ]; then
  doLog "Subtitle not found, executing subliminal"
  subliminal download -l ${LANGUAGE} "${EPISODE_PATH}" >> $LOG_FILE 2>&1
else
  doLog "Subtitle exists" 
fi
