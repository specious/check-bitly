#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Check if a domain is a Bitly domain"
  echo
  echo "Usage: $0 <domain>"
  exit 1
fi

LOCATION_HEADER=$(curl -sI "https://$1/1+" | grep Location)
CHECK_FOR="https://bitly.com/1+"

case $LOCATION_HEADER in
  *$CHECK_FOR*) echo "✔ $1 is a Bitly domain"
    ;;
  *) echo "✖ $1 is not a Bitly domain"
    ;;
esac
