#!/usr/bin/env bash

interval=10

while getopts "u:" opt; do
  case "$opt" in
    u) url="$OPTARG" ;;
    *)
      echo "-u is required."
      exit 1
      ;;
  esac
done

while true; do
  status_code=$(curl -I -s -o /dev/null -w "%{http_code}" -X HEAD $url)

  if [ $status_code -eq 200 ]; then
    echo "HTTP status code 200 returned. Deployment succeeded."
    break
  else
    echo "HTTP status code 200 not returned. Waiting for $interval seconds before retrying."
    sleep $interval
  fi
done
