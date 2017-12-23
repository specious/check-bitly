#!/bin/bash

check_domains() {
  cat "$1-domains.txt" | xargs ../check-bitly.sh
}

echo "Checking Bitly domains:"
echo
check_domains "bitly"

echo
echo "Checking non-Bitly domains:"
echo
check_domains "other"
