#!/usr/bin/env bash

export DEST=${DEST:-dist}
export TAG=${GITHUB_REF_NAME:-main}

rm -rf "$DEST"
mkdir "$DEST"

bazel build //cmd/...
bazel run --action_env=TAG="$TAG" //scripts/release:copy_assets
bazel run --action_env=TAG="$TAG" //scripts/release:git_archive
