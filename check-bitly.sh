#!/usr/bin/env bash

if [ $# -lt 1 ]
then
  echo "Check domains to see if they are Bitly domains"
  echo
  echo "Usage: $0 <domains...>"

  exit
fi

show_result() {
  case $1 in
    1) echo "✔ $domain is a Bitly domain"
    ;;

    *) echo "✖ $domain is not a Bitly domain"
    ;;
  esac
}

check_domain() {
  # The "Set-Cookie" header gives a Bitly domain away when accessing /1+
  header=$(curl -skI "https://$domain/1+" | grep -Fi set-cookie)
  marker="Domain=bitly.com;"

  case $header in
    *$marker*)
      show_result 1
      ;;

    *)
      show_result
      ;;
  esac
}

for domain in "$@"; do
  # Strip all subdomains
  main_domain=$(sed 's/.*\.\(.*\..*\)/\1/' <<< "${domain%/*}")

  case $main_domain in
    # These are undetectable using the subsequent technique
    bit.ly|j.mp|bitly.com)
      show_result 1
      ;;

    *)
      check_domain
      ;;
  esac
done
