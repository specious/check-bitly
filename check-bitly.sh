#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Check domains to see if they are Bitly domains"
  echo
  echo "Usage: $0 <domains...>"
  exit 1
fi

# DOMAIN=$1

show_result() {
  case $1 in
    1*) echo "✔ $DOMAIN is a Bitly domain"
    ;;

    *) echo "✖ $DOMAIN is not a Bitly domain"
    ;;
  esac
}

for DOMAIN in $@; do
  #
  # These are undetectable using the subsequent technique
  #
  if [[ $DOMAIN == "bitly.com" || $DOMAIN == "www.j.mp" ]]
  then
    show_result 1
    continue
  fi

  #
  # Regex match for Bitly domain in location redirect header
  #
  LOCATION_HEADER=$(curl -sI --insecure "https://$DOMAIN/1+" | grep Location)
  CHECK_FOR="https://bitly.com/"

  case $LOCATION_HEADER in
    *$CHECK_FOR*) show_result 1
      ;;
    *) show_result 0
      ;;
  esac
done
