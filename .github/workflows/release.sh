#!/usr/bin/env bash

host=$(uname -s)
NAME=tools
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}
PREFIX="${NAME}-${VERSION}"
RULES_ARCHIVE="${NAME}-${TAG}.tar.gz"

echo -n "build: Create Rules Archive"
git archive --format=tar \
  --add-virtual-file=${PREFIX}/MODULE.bazel:"$(sed "s/0.0.0/${VERSION}/" dist/MODULE.bazel)" \
  --add-virtual-file=${PREFIX}/BUILD.bazel:"$(cat dist/BUILD.root.bazel)" \
  --add-virtual-file=${PREFIX}/sh/BUILD.bazel:"$(cat dist/BUILD.sh.bazel)" \
  --prefix=${PREFIX}/ ${TAG} | gzip >$RULES_ARCHIVE
RULES_SHA=$(shasum -a 256 $RULES_ARCHIVE | awk '{print $1}')
echo " ... done ($RULES_ARCHIVE: $RULES_SHA)"

echo -n "build: Create Release Notes"
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
    remote = "git@github.com:bzlparty/tools.git",
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
    integrity = "sha256-${RULES_SHA}",
)
\`\`\`

## Checksums

**${RULES_ARCHIVE}** ${RULES_SHA}

EOF

echo " ... done"
