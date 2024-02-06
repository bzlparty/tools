#!/usr/bin/env bash

set -eou pipefail

SCRIPT_NAME=${_SCRIPT_NAME:-$0}

_print_help()
{
  cat << EOF
Synopsis:

  $SCRIPT_NAME [options] [--message <msg> | -m <msg>] <tag_name>
  $SCRIPT_NAME [options] --delete [<tag_name>]

Description:

  Small helper to create and remove git tags.

  $SCRIPT_NAME [options] [--message <msg> | -m <msg>] <tag_name>
      Create a git tag from the given <tag_name>. Unless the --message option
      is set, git will prompt the configured editor to enter a message.

  $SCRIPT_NAME [options] --delete [<tag_name>]
      Remove a tag by its name <tag_name>. If no <tag_name> argument is set,
      the latest tag will be removed.

Options:

  -p, --push       Push changes to remote.
  -u, --update     Update tags from remote before creating/removing a tag.
  -v, --verbose    Run verbosely.
  -h, --help       Print this message.

EOF
exit $?
}

_log()
{
  if [ $_VERBOSE -ne 0 ]; then 
    echo "$@";
  fi
}

[ $# -eq 0 ] && _print_help

_PUSH_CHANGES=0
_VERBOSE=0
_TAG=""
_DO="create"
_GIT_TAG_ARGS=""

while [ $# -ne 0 ]; do 
  case $1 in
    -h|--help) _print_help;;
    -m|--message) _GIT_TAG_ARGS="$1 $2"; shift;;
    -p|--push) _PUSH_CHANGES=1;;
    -u|--update) git fetch --tags;;
    -v|--verbose) _VERBOSE=1;;
    --delete)
      _DO="delete"
      if [ $# -eq 1 ]; then
        _TAG=$(git describe --abbrev=0)
        break
      fi
      shift;&
    *) _TAG=$1;;
  esac
  shift
done

cd "$BUILD_WORKING_DIRECTORY"

case $_DO in
  create)
    _log "Create tag $_TAG"
    git tag -a "$_TAG" "$_GIT_TAG_ARGS"

    if [ $_PUSH_CHANGES -eq 1 ]; then
      _log "Push changes"
      git push --tags
    fi
    ;;
  delete)
    _log "Delete tag $_TAG"
    git tag --delete "$_TAG"

    if [ $_PUSH_CHANGES -eq 1 ]; then
      _log "Push changes"
      git push --delete origin "$_TAG"
    fi
    ;;
esac

_log "Done!"
