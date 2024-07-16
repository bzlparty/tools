#!/usr/bin/env bash

function run_bin {
   local id;
   local bin;
   local bin_path;
   local cmd;
   local files;
   # shellcheck disable=SC2016
   id=$(echo "$1" | "$GOAWK_BIN" -F: '{print $1}')
   # shellcheck disable=SC2016
   bin=$(echo "$1" | "$GOAWK_BIN" -F: '{print $2}')
   bin_path=$(realpath "$bin")
   cmd=$("$JQ_BIN" -r ".$id.$MODE" _config_)

   # no command found, return
   if [ "$cmd" == "null" ]; then
     return
   fi

   cd "$PROJECT_DIR" || return

   # find files for every entry `files`
   while read -r line; do
     files+=$(eval "$FD_BIN" --type file -H -g \'"$line"\' --exclude ".git/" _exclude_ | tr \\n " ")
   done <<< "$($JQ_BIN -r ".$id.files.[]" "_config_" )"

   # no files found, return
   if [ -z "$files" ]; then
     return
   fi

   output=$(eval "$bin_path $cmd $files" 2>&1)

   exit_code=$?
   if [[ "$BAZEL_TEST" == "1" ]] && [[ "$exit_code" != "0" ]]; then
     exit_code=3
   fi

   # prepend uppercase $id to the output
   while read -r line; do
     [[ -n "$line" ]] && echo -e "\033[1m${id^^}\033[0m $line"
   done <<< "$output"

   exit $exit_code
}

FD_BIN=$(realpath "_fd_")
JQ_BIN=$(realpath "_jq_")
GOAWK_BIN=$(realpath "_goawk_")
MODE=_mode_
if [[ "$BAZEL_TEST" == "1" ]]; then
  PROJECT_DIR=$(dirname "$(realpath "_workspace_")")
else
  PROJECT_DIR=$BUILD_WORKING_DIRECTORY
fi

export -f run_bin
export FD_BIN
export JQ_BIN
export GOAWK_BIN
export MODE
export PROJECT_DIR

xargs --arg-file="_args_file_" -n 1 -P _jobs_ bash -c 'run_bin "$@"' {}
