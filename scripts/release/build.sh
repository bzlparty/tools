#!/usr/bin/env bash

DEST="$(pwd)/dist"
URL="https://github.com/bzlparty/tools/releases/download/$TAG"

if [ -z "$CI" ]; then
  URL="file://$(pwd)/$DEST"
fi

rm -rf "$DEST"
mkdir "$DEST"

export DEST

bazel run //scripts/release:copy_assets
bazel run \
  --//scripts/release:asset_url="$URL" \
  --@bzlparty_tools//lib:release_tag="$GITHUB_REF_NAME" \
  //scripts/release:git_archive
