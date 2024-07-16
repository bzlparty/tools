#!/usr/bin/env bash

if [[ -z "${TAG:-}" ]]; then
    echo -e >&2 "\033[1mERROR\033[0m [$(basename "$0")]\nTAG is not defined. Aborting!\n"
    exit 1
fi

VERSION=$TAG
[[ "$TAG" =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]] && VERSION=${TAG:1}
module_file=$(mktemp)
# shellcheck disable=SC2288
%DCOMMENT_BIN% -d _BZLPARTY_RELEASE_ %SRC% "$module_file"
sed "s/0.0.0/$VERSION/" "$module_file" > "%OUT%"
rm -rf "$module_file"
