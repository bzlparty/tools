#!/usr/bin/env bash

output=$(mktemp)

#shellcheck disable=SC2068,SC2288
%DCOMMENT% $@ > "$output"

if [ $? -gt 0 ]; then
  cat "$output"
  exit $?
fi
