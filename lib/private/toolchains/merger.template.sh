#!/usr/bin/env bash

# Create a temp file that holds a json object where we store the content
# of %INTEGRITY% and the respective shasum label from the used algo (%ALGO%).
integrity=$(mktemp)
cat > "$integrity" <<EOF
{
  "integrity": "sha%ALGO%-$(< %INTEGRITY%)"
}
EOF

# Merge the temp file and %SOURCE% to get the final file.
# shellcheck disable=SC2288
%JQ% -s '.[0] * .[1]' %SOURCE% "$integrity" > %OUT%
