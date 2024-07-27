#!/usr/bin/env bash

export DEST=${DEST:-dist}
export TAG=${GITHUB_REF_NAME:-main}
URL="https://github.com/bzlparty/tools/releases/download/$TAG"

if [ -z "$CI" ]; then
  URL="file://$(pwd)/$DEST"
fi

rm -rf "$DEST"
mkdir "$DEST"

bazel run //scripts/release:copy_assets
bazel run \
  --//scripts/release:asset_url="$URL" \
  --@bzlparty_tools//lib:release_tag="$TAG" \
  //scripts/release:git_archive
