#!/usr/bin/env bash

ALGO=384
TAG=${GITHUB_REF_NAME}
VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
PREFIX="tools-$VERSION"
RULES_ARCHIVE="./bzlparty_tools-$TAG.tar.gz"

module_file=$(mktemp)
root_build_file=$(mktemp)
toolchains_build_file=$(mktemp)

sed \
  -e "s/0.0.0/$VERSION/" \
  -e "/dev_dependency/d" \
  -e "/^$/d" \
  MODULE.bazel > "$module_file"

echo "package(default_visibility = [\"//visibility:public\"])" > "$root_build_file"
echo -e "load(\":toolchains.bzl\", \"all_toolchains\")\nall_toolchains()" > "$toolchains_build_file"

git archive --format=tar.gz \
  --prefix="$PREFIX/" \
  --add-virtual-file="$PREFIX/MODULE.bazel":"$(< "$module_file")" \
  --add-virtual-file="$PREFIX/BUILD.bazel":"$(< "$root_build_file")" \
  --add-virtual-file="$PREFIX/toolchains/BUILD.bazel":"$(< "$toolchains_build_file")" \
  -o "$RULES_ARCHIVE" "$TAG"

RULES_SHA=$(./sh/shasums.sh -a "$ALGO"  "$RULES_ARCHIVE")

echo "Created $RULES_ARCHIVE sha$ALGO:$RULES_SHA"

cat > release_notes.md <<EOF

## Installation

> [!IMPORTANT]  
> Installation is only supported via Bzlmod!

Choose from the options below and put as dependency in your \`MODULE.bazel\`.

### Install from BCR

\`\`\`starlark
bazel_dep(name = "bzlparty_tools", version = "${VERSION}")
\`\`\`


### Install from Git

\`\`\`starlark
bazel_dep(name = "bzlparty_tools")

git_override(
    module_name = "bzlparty_tools",
    remote = "https://github.com/bzlparty/tools.git",
    commit = "${GITHUB_SHA}",
)
\`\`\`

### Install from Archive

\`\`\`starlark
bazel_dep(name = "bzlparty_tools")

archive_override(
    module_name = "bzlparty_tools",
    urls = "https://github.com/bzlparty/tools/releases/download/${TAG}/${RULES_ARCHIVE}",
    strip_prefix = "${PREFIX}",
    integrity = "sha$ALGO-${RULES_SHA}",
)
\`\`\`

## Checksums

**${RULES_ARCHIVE}** sha$ALGO:${RULES_SHA}

EOF

echo "Created release_notes.md"
rm "$module_file" "$root_build_file" "$toolchains_build_file"
