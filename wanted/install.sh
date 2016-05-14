#!/bin/bash

SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $SCRIPT_PATH
function readHours {
  read -p "How ofter would you like to check for missed subtitles? (hours) " HOURS
  if [[ $HOURS -gt 23 ]]; then
    echo "Hour should be a value between 0 and 23"
    readHours
  fi
  echo $HOURS
}

declare HOURS=$(readHours)

#remove any previous cron jobs
(crontab -l ; echo "search-wanted.sh") 2>&1 | grep -v "no crontab" | grep -v search-wanted.sh |  sort | uniq | crontab -

# add a new cron job
(crontab -l ; echo "0 * * * * cd $SCRIPT_PATH; ./search-wanted.sh 2>&1 >> search.log") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

echo "Done ! check it by running: crontab -l"
