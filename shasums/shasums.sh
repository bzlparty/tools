#!/usr/bin/env bash
#
# A script to generate sha sums for assets form a given URL or github project.
# If sha sums are generated form a github project, note that *ALL* assets of
# the latest release are hashed.
#
# Options:
#   -a / --algo       shasum algo to use
#   -g / --github     Treat input as path to github project (owner/project), default
#   -u / --url        Treat input as single URL
#
#
# Run from Bazel:
#
# ```bash
# bazel run @bzlparty_tools//shasum foo/bar hello/world
# ```
#
# Run for a single URL:
#
# ```bash
# bazel run @bzlparty_tools//shasum -u https://example.com/path/to/asset.tar.gz
# ```

ALGO=384
URL=0

_curl()
{
  curl -sL \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GITHUB_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    $@
}

_fetch_from_github()
{
  _curl https://api.github.com/$@
}

_fetch_latest_release()
{
  _fetch_from_github "repos/$1/releases/latest"
}

_fetch_assets_from_release()
{
  _fetch_from_github "repos/$1/releases/$2/assets"
}

_hash_assets()
{
  for a in $@; do
    echo -n "`basename $a` "
    curl -L -s "${a}" | shasum -a $ALGO | awk "{ print \$1 }" | xxd -r -p | base64
  done
}

hash_assets_for_project()
{
  echo -e "\033[1m$1\033[0m"
  id=$(_fetch_latest_release $1 | jq -r ".id")
  asset_urls=$(_fetch_assets_from_release $1 $id | jq -r ".[] | .browser_download_url")
  
  _hash_assets $asset_urls
}

_print_help()
{
  echo -e "Usage: [-a <1, 224, 256, \033[1m384\033[0m, 512, 512224, 512256>] [-g <owner/project>... | -u <url>...]"
  exit 0
}

[ $# -eq 0 ] && _print_help;

while [ $# -ne 0 ]; do
  case $1 in
    -h|--help)
      _print_help;;
    -a|--algo)
      ALGO="$2"; shift;;
    -g|--github)
      GITHUB=1 URL=0;;
    -u|--url)
      URL=1 GITHUB=0;;
    *)
      if [ "$URL" -eq 1 ]; then _hash_assets $@; break; fi
      hash_assets_for_project "$1";;
  esac
  shift; 
done
