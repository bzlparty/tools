#!/usr/bin/env bash

RULES_ARCHIVE="%DEST%/%NAME%-%COMMIT%.tar.gz"
SHA_BIN=$(realpath "%SHA%")

cd "$BUILD_WORKING_DIRECTORY" || exit 1

git archive --format=tar.gz --prefix="%NAME%-%VERSION%/" %VIRTUAL_FILES% -o "$RULES_ARCHIVE" "%COMMIT%"
eval "$SHA_BIN -file $RULES_ARCHIVE" > "$RULES_ARCHIVE".sha384
