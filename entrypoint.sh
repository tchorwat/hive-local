#!/bin/bash
set -e

if [ "$1" = 'hiveserver2' ] || [ -z "$1" ]; then
  if [ "$1" = 'hiveserver2' ]; then
    shift 1
  fi
  /hive/apache-hive-1.2.2-bin/bin/hiveserver2 "$@" &>/dev/null &
  tail -f /dev/null
elif [ "$1" = 'beeline' ]; then
  shift 1;
  defUrl='-u jdbc:hive2://'
  for args in "$@"
  do
    if [ "$args" = '-u' ]; then
      defUrl=''
    fi
  done
  /hive/apache-hive-1.2.2-bin/bin/beeline "$defUrl" "$@"
else
  # else default to run whatever the user wanted like "bash" or "sh"
  exec "$@"
fi
