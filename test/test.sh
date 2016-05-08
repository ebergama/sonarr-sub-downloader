#!/bin/bash

declare MY_DIR=`dirname $0`
declare LOG_FILE=$MY_DIR/../sub-downloader.log

function cleanLog {
  if [[ -f $LOG_FILE ]]; then
    rm $LOG_FILE
  fi
}

function assert {
  echo "assert $1"
  if $1; then
    echo "o Done"
  else
    echo "x Failed"
    exit 1
  fi
}

function printHelpTest {
  echo "----- Print help test -----"
  cleanLog
  $MY_DIR/../sub-downloader.sh
  assert "test -f $LOG_FILE"
}

function uncompleteArgsTest {
  echo "----- Uncomplete args test -----"
  cleanLog
  $MY_DIR/../sub-downloader.sh -l
  assert "test $? -eq 1"
  assert "test ! -f $LOG_FILE"
}

function doDownloadLang {
  echo "----- Simple download test -----"
  export sonarr_episodefile_path=The.Big.Bang.Theory.S05E18.HDTV.x264-LOL.mp4 
  cleanLog
  . $MY_DIR/../sub-downloader.sh -l es,en
  assert "test -f $LOG_FILE"
  assert "test -f ./The.Big.Bang.Theory.S05E18.HDTV.x264-LOL.es.srt"
  assert "test -f ./The.Big.Bang.Theory.S05E18.HDTV.x264-LOL.en.srt"
  rm ./The.Big.Bang.Theory.S05E18.HDTV.x264-LOL.*.srt
}

printHelpTest
uncompleteArgsTest
doDownloadLang

