#!/usr/bin/env bash

export DEST=${DEST:-dist}
export TAG=${GITHUB_REF_NAME:-main}
VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
PREFIX="tools-$VERSION"
E2E_DIR="archive_e2e"

cp -r e2e/ "$E2E_DIR"

rules_archive="tools-$TAG".tar.gz
archive_file_path=$(realpath "$DEST/$rules_archive")
archive_integrity=$(< "$archive_file_path".sha384)

cat > archive_e2e/MODULE.bazle <<EOF
module(name = "bzlparty_tools_e2e")

bazel_dep(name = "bazel_skylib", version = "1.7.1")
bazel_dep(name = "bzlparty_tools")
archive_override(
    module_name = "bzlparty_tools",
    urls = ["file://$archive_file_path"],
    strip_prefix = "$PREFIX",
    integrity = "sha384-$archive_integrity",
)
EOF

cd "$E2E_DIR" || exit 1
bazel test //...
