#!/usr/bin/env bash

set -uo pipefail

if [[ -z "${TAG:-}" ]]; then
    echo -e >&2 "\033[1mERROR\033[0m [$(basename "$0")]\nTAG is not defined. Aborting!\n"
    exit 1
fi

VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
PREFIX="%NAME%-$VERSION"
RULES_ARCHIVE="$DEST/%NAME%-$TAG.tar.gz"

cd "$BUILD_WORKING_DIRECTORY" || exit 1

git archive --format=tar.gz --prefix="$PREFIX/" %VIRTUAL_FILES% -o "$RULES_ARCHIVE" "$TAG"
# shellcheck disable=SC2288
%SHA% "$RULES_ARCHIVE" > "$RULES_ARCHIVE".sha384
