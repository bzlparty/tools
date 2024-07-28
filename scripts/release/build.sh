#!/usr/bin/env bash

DEST="$(pwd)/dist"
URL="https://github.com/bzlparty/tools/releases/download/$TAG"
TAG=${GITHUB_REF_NAME:-main}

if [ -z "$CI" ]; then
  URL="file://$DEST"
fi

rm -rf "$DEST"; mkdir "$DEST"

export DEST

bazel run //scripts/release:copy_assets
bazel run \
  --@bzlparty_tools//lib:release_dir="$DEST" \
  --@bzlparty_tools//lib:release_tag="$TAG" \
  --//scripts/release:assets_url="$URL" \
  //scripts/release:git_archive
