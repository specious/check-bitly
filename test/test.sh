#!/usr/bin/env bash

check_domains() {
  cat "$1-domains.txt" | xargs ../check-bitly.sh
}

echo "Checking known Bitly domains:"
echo
check_domains bitly

echo
echo "Checking non-Bitly domains:"
echo
check_domains other
