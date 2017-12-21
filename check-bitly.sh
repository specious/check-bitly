#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Check if a domain is a Bitly domain"
  echo
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

show_result() {
  case $1 in
    1*) echo "✔ $DOMAIN is a Bitly domain"
    ;;

    *) echo "✖ $DOMAIN is not a Bitly domain"
    ;;
  esac
}

#
# bitly.com itself is undetectable using the subsequent technique
#
if [[ $DOMAIN == "bitly.com" ]]
then
  show_result 1
  exit 1
fi

LOCATION_HEADER=$(curl -sI "https://$1/1+" | grep Location)
CHECK_FOR="https://bitly.com/1+"

case $LOCATION_HEADER in
  *$CHECK_FOR*) show_result 1
    ;;
  *) show_result 0
    ;;
esac
