#!/usr/bin/env bash

export DEST=${DEST:-dist}
export TAG=${GITHUB_REF_NAME:-main}
URL="https://github.com/bzlparty/tools/releases/download/$TAG"

if [ -z "$CI" ]; then
  URL="file://$(pwd)/$DEST"
fi

rm -rf "$DEST"
mkdir "$DEST"

bazel run --action_env=TAG="$TAG" //scripts/release:copy_assets
bazel run --//scripts/release:asset_url="$URL" --action_env=TAG="$TAG" //scripts/release:git_archive
