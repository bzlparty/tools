#!/usr/bin/env bash

host=$(uname -s)
NAME=tools
TAG=${GITHUB_REF_NAME}
VERSION=${TAG:1}
PREFIX="${NAME}-${VERSION}"
RULES_ARCHIVE="${NAME}-${TAG}.tar.gz"

echo -n "build: Create Rules Archive"
MODULE_BAZEL_FILE="\
module(
    name = \"bzlparty_tools\",
    version = \"${VERSION}\",
    compatibility_level = 1,
)
bazel_dep(name = \"platforms\", version = \"0.0.8\")
bazel_dep(name = \"bazel_skylib\", version = \"1.5.0\")
"
git archive --format=tar \
  --add-virtual-file=${PREFIX}/MODULE.bazel:"${MODULE_BAZEL_FILE}" \
  --add-virtual-file=${PREFIX}/BUILD.bazel:"package(default_visibility = [\"//visibility:public\"])" \
  --add-virtual-file=${PREFIX}/lib/BUILD.bazel:"$(cat dist/lib.BUILD.bazel)" \
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
