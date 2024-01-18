#!/usr/bin/env bash
#
# A script to generate sha sums for assets of a github release.
# Shasums are generated for *ALL* assets of the release.
#
# Options:
#   -a / --algo       shasum algo to use
#
#
# Run from Bazel:
#
# ```bash
# bazel run @bzlparty_tools//shasum foo/bar hello/world
# ```

ALGO=384

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

# This is the main function.
# From a given project path (owner/project), we get the latest release to fetch
# all assets from, then hash each of them with the set ALGO.
hash_assets_for_project()
{
  echo -e "\033[1m$1\033[0m"
  id=$(_fetch_latest_release $1 | jq -r ".id")
  asset_urls=$(_fetch_assets_from_release $1 $id | jq -r ".[] | .browser_download_url")
  
  _hash_assets $asset_urls

}

while [ $# -ne 0 ]; do
  case $1 in
    -h|--help|"")
      echo -e "Usage: [-a <1, 224, 256, \033[1m384\033[0m, 512, 512224, 512256>] [-o <file>] <owner/project>..."; exit 0;;
    -a|--algo)
      ALGO="$2"; shift;;
    *)
      hash_assets_for_project "$1";;
  esac
  shift; 
done
