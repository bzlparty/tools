#!/usr/bin/env bash

DEST="$(pwd)/dist"

export DEST

bazel run \
  --@bzlparty_tools//lib:release_dir="$DEST" \
  --@bzlparty_tools//lib:release_tag="$GITHUB_REF_NAME" \
  //scripts/release:release_notes
