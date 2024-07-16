#!/usr/bin/env bash
usage() { echo "$0 usage:" && grep " .)\ #" $0; exit 0; }
[ $# -eq 0 ] && usage
while getopts ":cxht:" arg; do
  case $arg in
    c) # Set CI=true as in github workflows.
      export CI=true
      ;;
    x) # Clean directories before build.
      rm -rf "$DEST"
      ;;
    h | *) # Display help.
      usage
      ;;
  esac
done
