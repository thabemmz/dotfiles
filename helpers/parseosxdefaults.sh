#!/usr/bin/env bash
if [ -z "$1" ]; then
  echo "Provide default to read" 1>&2
  exit 1;
fi

DOMAIN=$1
READ="$(defaults read $DOMAIN)"

function print_defaultswrite_for() {
  while read line; do
    if [[ $line == "{" || $line == "}" ]]; then
      continue
    fi
    KEYVAL=($(tr '=' ' ' <<< $line))
    KEY=${KEYVAL[0]}
    VAL=${KEYVAL[1]//;}
    if [[ $2 == "override" ]]; then
      echo "\"$KEY\" = $VAL;"
    else
      echo "defaults write $DOMAIN \"$KEY\" '$VAL'"
    fi
  done <<< "$1"
}

function print_line() {
  echo "========================================================================="
}

if [ -z "$2" ]; then
  echo "Printing write commands in no-override mode:"
  print_line
  print_defaultswrite_for "${READ}"
  print_line
  exit 0;
else
  echo "Printing write commands in override mode:"
  print_line
  echo "defaults write $DOMAIN '{ "
  print_defaultswrite_for "${READ}" "override"
  echo " }'"
  print_line
fi
