#!/usr/bin/env bash

ALGO=256
TAG=${GITHUB_REF_NAME}
VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
RULES_ARCHIVE="./bzlparty_tools-$TAG.tar.gz"

sed -i "s|0.0.0|$VERSION|" MODULE.bazel
bazel build //scripts:dist
OUTPUT=$(bazel 2>/dev/null cquery --output=files "//scripts:dist")
cp "$OUTPUT" "$RULES_ARCHIVE"
RULES_SHA=$(bazel 2>/dev/null run //sh:shasums -- -a "$ALGO"  "$RULES_ARCHIVE")
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
